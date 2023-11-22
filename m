Return-Path: <linux-fpga+bounces-26-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47377F4901
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Nov 2023 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770BA28162D
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Nov 2023 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068724E601;
	Wed, 22 Nov 2023 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SE+MqbM8"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57151D54
	for <linux-fpga@vger.kernel.org>; Wed, 22 Nov 2023 06:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700663597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shPFiNnieBfc+nA1jRG7H+c1jqVnxbi/cSpxWrKoPIY=;
	b=SE+MqbM8muc+gYoCFiu1IHCej7K327Ja5hIJ0vVD7SWe3OO5Eyrksq8l19S+lMdLxaS48H
	1HKDrGN/GYDLylxFjMnat9tKSduobhWA+oXyU1Ufh+4fuGwJKdz/JhLk0MckoX2SJH/VDI
	CIpDf1jRVc/cLYlwSvSSWmm3eYEjO/s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-eekr55nmMvO7aOL4syTLwA-1; Wed, 22 Nov 2023 09:33:16 -0500
X-MC-Unique: eekr55nmMvO7aOL4syTLwA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cdc2cc0b4so19291841cf.0
        for <linux-fpga@vger.kernel.org>; Wed, 22 Nov 2023 06:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700663595; x=1701268395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shPFiNnieBfc+nA1jRG7H+c1jqVnxbi/cSpxWrKoPIY=;
        b=kFJbnu9zgSVN2Xv7vm7J4euzxbd/kuXs5ghdiViQ3PbVNYIc68kXXME8PhsY71ewA3
         oDmLkDuoKhv7MI9dxDr0bfPtJsHuvh7fSkKKQ5PJLfK/HaoE2X9I8T0m3E9XeULoJUCg
         e0C495BefC3Em7HhdGN7JyodZCBG4eqvsjYg2YOH7tlNTaVTb/Zkz9lOcF21qHWsOmcs
         Y7CV/0xWuqiuZAopkoxEerKYfuPmjcscP5g36nDBY30jgwqptZce/j0qKaixqUTfJ5KC
         M9bxCZA6buh2lpxCrQGHVIDY3NUo69EzVoykxAcj+am4+UesIwL4gsHKh3je6tt1Z3DS
         pIHw==
X-Gm-Message-State: AOJu0YzM/olfjFvV8J00gQ0VKLnN7L+8sjK1Z4CDrWeNFQ+xn2z+tvz0
	25joCoPjbVjsv11cqWd8ikZJMPzJeqbCSzLDjoGlejinnVQRQfhYlVwUMt0AcKuvowvAvyabbjf
	4Law7TnKwjDG5cvHQ+Zoj
X-Received: by 2002:a05:622a:400c:b0:423:83a1:7bbf with SMTP id cf12-20020a05622a400c00b0042383a17bbfmr1127402qtb.28.1700663594745;
        Wed, 22 Nov 2023 06:33:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV9BlytQs81yJF+crBKuitlDdNCMdUFK9qjRxbV/xMqx4YvOghdpr9UcA3xpf4yEHJXbAFSg==
X-Received: by 2002:a05:622a:400c:b0:423:83a1:7bbf with SMTP id cf12-20020a05622a400c00b0042383a17bbfmr1127366qtb.28.1700663594488;
        Wed, 22 Nov 2023 06:33:14 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id v7-20020ac87487000000b0041950c7f6d8sm4430101qtq.60.2023.11.22.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:33:14 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH 2/2] fpga: set owner of fpga_manager_ops for existing low-level modules
Date: Wed, 22 Nov 2023 15:32:52 +0100
Message-ID: <20231122143252.181680-3-marpagan@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122143252.181680-1-marpagan@redhat.com>
References: <20231122143252.181680-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch tentatively set the owner field of fpga_manager_ops to
THIS_MODULE for existing fpga manager low-level control modules.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/altera-cvp.c             | 1 +
 drivers/fpga/altera-pr-ip-core.c      | 1 +
 drivers/fpga/altera-ps-spi.c          | 1 +
 drivers/fpga/dfl-fme-mgr.c            | 1 +
 drivers/fpga/ice40-spi.c              | 1 +
 drivers/fpga/lattice-sysconfig.c      | 1 +
 drivers/fpga/machxo2-spi.c            | 1 +
 drivers/fpga/microchip-spi.c          | 1 +
 drivers/fpga/socfpga-a10.c            | 1 +
 drivers/fpga/socfpga.c                | 1 +
 drivers/fpga/stratix10-soc.c          | 1 +
 drivers/fpga/tests/fpga-mgr-test.c    | 1 +
 drivers/fpga/tests/fpga-region-test.c | 1 +
 drivers/fpga/ts73xx-fpga.c            | 1 +
 drivers/fpga/versal-fpga.c            | 1 +
 drivers/fpga/xilinx-spi.c             | 1 +
 drivers/fpga/zynq-fpga.c              | 1 +
 drivers/fpga/zynqmp-fpga.c            | 1 +
 18 files changed, 18 insertions(+)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4ffb9da537d8..aeb913547dd8 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -520,6 +520,7 @@ static const struct fpga_manager_ops altera_cvp_ops = {
 	.write_init	= altera_cvp_write_init,
 	.write		= altera_cvp_write,
 	.write_complete	= altera_cvp_write_complete,
+	.owner		= THIS_MODULE,
 };
 
 static const struct cvp_priv cvp_priv_v1 = {
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index df8671af4a92..354221c609e6 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -171,6 +171,7 @@ static const struct fpga_manager_ops alt_pr_ops = {
 	.write_init = alt_pr_fpga_write_init,
 	.write = alt_pr_fpga_write,
 	.write_complete = alt_pr_fpga_write_complete,
+	.owner = THIS_MODULE,
 };
 
 int alt_pr_register(struct device *dev, void __iomem *reg_base)
diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 740980e7cef8..3be05796a6fc 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -228,6 +228,7 @@ static const struct fpga_manager_ops altera_ps_ops = {
 	.write_init = altera_ps_write_init,
 	.write = altera_ps_write,
 	.write_complete = altera_ps_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int altera_ps_probe(struct spi_device *spi)
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index ab228d8837a0..740ce82e3ac9 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -264,6 +264,7 @@ static const struct fpga_manager_ops fme_mgr_ops = {
 	.write = fme_mgr_write,
 	.write_complete = fme_mgr_write_complete,
 	.status = fme_mgr_status,
+	.owner = THIS_MODULE,
 };
 
 static void fme_mgr_get_compat_id(void __iomem *fme_pr,
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 7cbb3558b844..97afa6dc5d76 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -130,6 +130,7 @@ static const struct fpga_manager_ops ice40_fpga_ops = {
 	.write_init = ice40_fpga_ops_write_init,
 	.write = ice40_fpga_ops_write,
 	.write_complete = ice40_fpga_ops_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int ice40_fpga_probe(struct spi_device *spi)
diff --git a/drivers/fpga/lattice-sysconfig.c b/drivers/fpga/lattice-sysconfig.c
index ba51a60f672f..1393cdd11e49 100644
--- a/drivers/fpga/lattice-sysconfig.c
+++ b/drivers/fpga/lattice-sysconfig.c
@@ -348,6 +348,7 @@ static const struct fpga_manager_ops sysconfig_fpga_mgr_ops = {
 	.write_init = sysconfig_ops_write_init,
 	.write = sysconfig_ops_write,
 	.write_complete = sysconfig_ops_write_complete,
+	.owner = THIS_MODULE,
 };
 
 int sysconfig_probe(struct sysconfig_priv *priv)
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 905607992a12..46193a47f863 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -358,6 +358,7 @@ static const struct fpga_manager_ops machxo2_ops = {
 	.write_init = machxo2_write_init,
 	.write = machxo2_write,
 	.write_complete = machxo2_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int machxo2_spi_probe(struct spi_device *spi)
diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 2a82c726d6e5..023ccdf2d5da 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -362,6 +362,7 @@ static const struct fpga_manager_ops mpf_ops = {
 	.write_init = mpf_ops_write_init,
 	.write = mpf_ops_write,
 	.write_complete = mpf_ops_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int mpf_probe(struct spi_device *spi)
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index cc4861e345c9..a8ab74b30006 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -463,6 +463,7 @@ static const struct fpga_manager_ops socfpga_a10_fpga_mgr_ops = {
 	.write_init = socfpga_a10_fpga_write_init,
 	.write = socfpga_a10_fpga_write,
 	.write_complete = socfpga_a10_fpga_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int socfpga_a10_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 723ea0ad3f09..87f3f4a367d0 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -538,6 +538,7 @@ static const struct fpga_manager_ops socfpga_fpga_ops = {
 	.write_init = socfpga_fpga_ops_configure_init,
 	.write = socfpga_fpga_ops_configure_write,
 	.write_complete = socfpga_fpga_ops_configure_complete,
+	.owner = THIS_MODULE,
 };
 
 static int socfpga_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index cacb9cc5757e..63a5a2fe4911 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -393,6 +393,7 @@ static const struct fpga_manager_ops s10_ops = {
 	.write_init = s10_ops_write_init,
 	.write = s10_ops_write,
 	.write_complete = s10_ops_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int s10_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
index 6acec55b60ce..4c2a3e98f8ad 100644
--- a/drivers/fpga/tests/fpga-mgr-test.c
+++ b/drivers/fpga/tests/fpga-mgr-test.c
@@ -187,6 +187,7 @@ static const struct fpga_manager_ops fake_mgr_ops = {
 	.write = op_write,
 	.write_sg = op_write_sg,
 	.write_complete = op_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static void fpga_mgr_test_get(struct kunit *test)
diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
index baab07e3fc59..2705c1b33d09 100644
--- a/drivers/fpga/tests/fpga-region-test.c
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -52,6 +52,7 @@ static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
  */
 static const struct fpga_manager_ops fake_mgr_ops = {
 	.write = op_write,
+	.owner = THIS_MODULE,
 };
 
 static int op_enable_set(struct fpga_bridge *bridge, bool enable)
diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 4e1d2a4d3df4..20b8db0d150a 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -96,6 +96,7 @@ static const struct fpga_manager_ops ts73xx_fpga_ops = {
 	.write_init	= ts73xx_fpga_write_init,
 	.write		= ts73xx_fpga_write,
 	.write_complete	= ts73xx_fpga_write_complete,
+	.owner		= THIS_MODULE,
 };
 
 static int ts73xx_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
index 3710e8f01be2..02fd8ed36ff0 100644
--- a/drivers/fpga/versal-fpga.c
+++ b/drivers/fpga/versal-fpga.c
@@ -40,6 +40,7 @@ static int versal_fpga_ops_write(struct fpga_manager *mgr,
 static const struct fpga_manager_ops versal_fpga_ops = {
 	.write_init = versal_fpga_ops_write_init,
 	.write = versal_fpga_ops_write,
+	.owner = THIS_MODULE,
 };
 
 static int versal_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index e1a227e7ff2a..d58cf0ccbd41 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -218,6 +218,7 @@ static const struct fpga_manager_ops xilinx_spi_ops = {
 	.write_init = xilinx_spi_write_init,
 	.write = xilinx_spi_write,
 	.write_complete = xilinx_spi_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int xilinx_spi_probe(struct spi_device *spi)
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 96611d424a10..241e1fe48a13 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -548,6 +548,7 @@ static const struct fpga_manager_ops zynq_fpga_ops = {
 	.write_init = zynq_fpga_ops_write_init,
 	.write_sg = zynq_fpga_ops_write,
 	.write_complete = zynq_fpga_ops_write_complete,
+	.owner = THIS_MODULE,
 };
 
 static int zynq_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index f3434e2c487b..2f66400d2330 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -101,6 +101,7 @@ static const struct fpga_manager_ops zynqmp_fpga_ops = {
 	.state = zynqmp_fpga_ops_state,
 	.write_init = zynqmp_fpga_ops_write_init,
 	.write = zynqmp_fpga_ops_write,
+	.owner = THIS_MODULE,
 };
 
 static int zynqmp_fpga_probe(struct platform_device *pdev)
-- 
2.42.0


