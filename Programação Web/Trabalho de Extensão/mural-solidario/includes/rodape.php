</main>

<footer class="rodape mt-5">
    <div class="container py-4">
        <div class="row g-4">
            <div class="col-md-5">
                <h6 class="fw-bold"><i class="bi bi-box2-heart-fill me-1"></i> Mural Solidário</h6>
                <p class="small mb-0">
                    Um jeito simples de ajudar: veja o que a entidade precisa, escolha um item e leve até lá.
                </p>
            </div>
            <div class="col-md-4">
                <h6 class="fw-bold">Onde entregar</h6>
                <p class="small mb-1"><i class="bi bi-geo-alt-fill me-1"></i><?= e(ENTIDADE_ENDERECO) ?></p>
                <p class="small mb-0"><i class="bi bi-clock-fill me-1"></i><?= e(ENTIDADE_HORARIO) ?></p>
            </div>
            <div class="col-md-3">
                <h6 class="fw-bold">Contato</h6>
                <p class="small mb-0"><i class="bi bi-telephone-fill me-1"></i><?= e(ENTIDADE_TELEFONE) ?></p>
            </div>
        </div>
        <hr>
        <p class="small text-center mb-0">
            Projeto de Extensão de Programação Web I &middot; Sistemas de Informação - UNIDAVI
        </p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<?= $base ?>js/script.js"></script>
</body>
</html>
