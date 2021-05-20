Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549DA38B5FC
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 20:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhETSbE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 14:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232201AbhETSbE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 14:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621535382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=POHXKYzULA5oWa27Ew+oWlRnF6lqDlqLjp7TIyGzJG0=;
        b=BKiBF34TqOr+ab2khRV6HjdLdOYZeM6aZUx6GPWgKC0aJE9EZpkrS68KK6qWqmrz0IWRfQ
        E2MKBBXRc7tv8uR1+4R+/LYSx0qQvRCeG6c8mbSmF7ffS0I5DISp1/OQ9A+8XmEauw+sRM
        s571VGqFMBJHB8DVrW9/Dp/78Xrz0RI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-VZ8ADJsdNhyVrbZ3M8ij3A-1; Thu, 20 May 2021 14:29:36 -0400
X-MC-Unique: VZ8ADJsdNhyVrbZ3M8ij3A-1
Received: by mail-qv1-f72.google.com with SMTP id n12-20020a0c8c0c0000b02901edb8963d4dso13959335qvb.18
        for <linux-fpga@vger.kernel.org>; Thu, 20 May 2021 11:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=POHXKYzULA5oWa27Ew+oWlRnF6lqDlqLjp7TIyGzJG0=;
        b=KMNi34S7Ltt1z0LUPUVdSMBzCj9Q3smRkV7k6RFF7Vg3BBKXO2Ti6C15ye1VsNbq6x
         JArQoHxhlFghOh5C4CqS5q7Qx8+maqUHnpKoj5jg/VxGuTGwAyR7hYCzLzqgg9eeX558
         tEm8KB2WpiIxxbBhZZgYZE4qqwtGM8wbUjglb7nOaGdp262nahEp/0OGnmyh2vhVf0w7
         RW7ub7fgrOGbHtv78PLtYvIWCOEKP5VBhdL66kaDo6kvmUoHK05PVNaewLv3gU8+aZDl
         oifrAXGdxi6rrAJsAEFLgug73rAA2CSMCl+lv7MsVaUsy3NVmeDaWYXnO7As15Lb3LJX
         mq1g==
X-Gm-Message-State: AOAM531XVOa8NAYC5w103YManJ3+Gp2LPT0MiHo/h7gxi+LKSs84q1V+
        oytvBww+ucGZSgwPrbjIq9MVSIWoteGWl+lLPJdez3+3PNU9dzovR1lLF+p/Y2UohkcaFdcmleM
        AT5z5dtox9YHJ/qrNdQVV4g==
X-Received: by 2002:a05:6214:902:: with SMTP id dj2mr7292231qvb.11.1621535375216;
        Thu, 20 May 2021 11:29:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxijynAHoHHDjGI6+PuPf8C7ppXOuU2wL3IaZQMUyMKk1I5g4O+S2Q9LLR0/c5iX5OYEo8CFg==
X-Received: by 2002:a05:6214:902:: with SMTP id dj2mr7292198qvb.11.1621535374957;
        Thu, 20 May 2021 11:29:34 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h10sm2703247qka.26.2021.05.20.11.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:29:34 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 1/5] fpga: generalize updating the card
Date:   Thu, 20 May 2021 11:29:30 -0700
Message-Id: <20210520182930.2021923-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

There is a need to update the whole card.  An fpga can
contain non-fpga components whose firmware needs to be
updated at the same time as the fpga rtl images and
may need to be handled differently from the existing
fpga reconfiguration in the the fpga manager.

Move the write_* ops out of fpga_manager_ops and
into a new fpga_manager_update_ops struct.  Add
two update_ops back to fpga_manager_ops,
reconfig for the exiting functionality and
reimage for the new functionity.

Rewire fpga devs to use reconfig ops

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/altera-cvp.c        |  8 ++++----
 drivers/fpga/altera-pr-ip-core.c |  8 ++++----
 drivers/fpga/altera-ps-spi.c     |  8 ++++----
 drivers/fpga/dfl-fme-mgr.c       | 10 +++++-----
 drivers/fpga/fpga-mgr.c          | 23 ++++++++++++-----------
 drivers/fpga/ice40-spi.c         |  8 ++++----
 drivers/fpga/machxo2-spi.c       |  8 ++++----
 drivers/fpga/socfpga-a10.c       | 10 +++++-----
 drivers/fpga/socfpga.c           |  8 ++++----
 drivers/fpga/stratix10-soc.c     |  8 ++++----
 drivers/fpga/ts73xx-fpga.c       |  8 ++++----
 drivers/fpga/xilinx-spi.c        |  8 ++++----
 drivers/fpga/zynq-fpga.c         | 10 +++++-----
 drivers/fpga/zynqmp-fpga.c       |  8 ++++----
 include/linux/fpga/fpga-mgr.h    | 32 +++++++++++++++++++++-----------
 15 files changed, 88 insertions(+), 77 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4e0edb60bfba6..e107651f89bbd 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -516,10 +516,10 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops altera_cvp_ops = {
-	.state		= altera_cvp_state,
-	.write_init	= altera_cvp_write_init,
-	.write		= altera_cvp_write,
-	.write_complete	= altera_cvp_write_complete,
+	.state                   = altera_cvp_state,
+	.reconfig.write_init     = altera_cvp_write_init,
+	.reconfig.write          = altera_cvp_write,
+	.reconfig.write_complete = altera_cvp_write_complete,
 };
 
 static const struct cvp_priv cvp_priv_v1 = {
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index 5b130c4d98829..3385587679d5b 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -167,10 +167,10 @@ static int alt_pr_fpga_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops alt_pr_ops = {
-	.state = alt_pr_fpga_state,
-	.write_init = alt_pr_fpga_write_init,
-	.write = alt_pr_fpga_write,
-	.write_complete = alt_pr_fpga_write_complete,
+	.state                   = alt_pr_fpga_state,
+	.reconfig.write_init     = alt_pr_fpga_write_init,
+	.reconfig.write          = alt_pr_fpga_write,
+	.reconfig.write_complete = alt_pr_fpga_write_complete,
 };
 
 int alt_pr_register(struct device *dev, void __iomem *reg_base)
diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 23bfd4d1ad0f7..2b01a3c53d374 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -231,10 +231,10 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops altera_ps_ops = {
-	.state = altera_ps_state,
-	.write_init = altera_ps_write_init,
-	.write = altera_ps_write,
-	.write_complete = altera_ps_write_complete,
+	.state                   = altera_ps_state,
+	.reconfig.write_init     = altera_ps_write_init,
+	.reconfig.write          = altera_ps_write,
+	.reconfig.write_complete = altera_ps_write_complete,
 };
 
 static const struct altera_ps_data *id_to_data(const struct spi_device_id *id)
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index d5861d13b3069..89913d27d877c 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -265,11 +265,11 @@ static u64 fme_mgr_status(struct fpga_manager *mgr)
 }
 
 static const struct fpga_manager_ops fme_mgr_ops = {
-	.write_init = fme_mgr_write_init,
-	.write = fme_mgr_write,
-	.write_complete = fme_mgr_write_complete,
-	.state = fme_mgr_state,
-	.status = fme_mgr_status,
+	.state                   = fme_mgr_state,
+	.status                  = fme_mgr_status,
+	.reconfig.write_init     = fme_mgr_write_init,
+	.reconfig.write          = fme_mgr_write,
+	.reconfig.write_complete = fme_mgr_write_complete,
 };
 
 static void fme_mgr_get_compat_id(void __iomem *fme_pr,
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index b85bc47c91a9a..e3fc1b0bd7181 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -83,9 +83,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 	if (!mgr->mops->initial_header_size)
-		ret = mgr->mops->write_init(mgr, info, NULL, 0);
+		ret = mgr->mops->reconfig.write_init(mgr, info, NULL, 0);
 	else
-		ret = mgr->mops->write_init(
+		ret = mgr->mops->reconfig.write_init(
 		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
 
 	if (ret) {
@@ -147,7 +147,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	ret = mgr->mops->write_complete(mgr, info);
+	ret = mgr->mops->reconfig.write_complete(mgr, info);
 	if (ret) {
 		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
@@ -187,14 +187,14 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 
 	/* Write the FPGA image to the FPGA. */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	if (mgr->mops->write_sg) {
-		ret = mgr->mops->write_sg(mgr, sgt);
+	if (mgr->mops->reconfig.write_sg) {
+		ret = mgr->mops->reconfig.write_sg(mgr, sgt);
 	} else {
 		struct sg_mapping_iter miter;
 
 		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter)) {
-			ret = mgr->mops->write(mgr, miter.addr, miter.length);
+			ret = mgr->mops->reconfig.write(mgr, miter.addr, miter.length);
 			if (ret)
 				break;
 		}
@@ -224,7 +224,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	 * Write the FPGA image to the FPGA.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	ret = mgr->mops->write(mgr, buf, count);
+	ret = mgr->mops->reconfig.write(mgr, buf, count);
 	if (ret) {
 		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
@@ -264,7 +264,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	 * contiguous kernel buffer and the driver doesn't require SG, non-SG
 	 * drivers will still work on the slow path.
 	 */
-	if (mgr->mops->write)
+	if (mgr->mops->reconfig.write)
 		return fpga_mgr_buf_load_mapped(mgr, info, buf, count);
 
 	/*
@@ -568,9 +568,10 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->write_complete || !mops->state ||
-	    !mops->write_init || (!mops->write && !mops->write_sg) ||
-	    (mops->write && mops->write_sg)) {
+	if (!mops || !mops->reconfig.write_complete || !mops->state ||
+	    !mops->reconfig.write_init || (!mops->reconfig.write &&
+						 !mops->reconfig.write_sg) ||
+	    (mops->reconfig.write && mops->reconfig.write_sg)) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 69dec5af23c36..3bdc3fe8ece97 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -126,10 +126,10 @@ static int ice40_fpga_ops_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops ice40_fpga_ops = {
-	.state = ice40_fpga_ops_state,
-	.write_init = ice40_fpga_ops_write_init,
-	.write = ice40_fpga_ops_write,
-	.write_complete = ice40_fpga_ops_write_complete,
+	.state                   = ice40_fpga_ops_state,
+	.reconfig.write_init     = ice40_fpga_ops_write_init,
+	.reconfig.write          = ice40_fpga_ops_write,
+	.reconfig.write_complete = ice40_fpga_ops_write_complete,
 };
 
 static int ice40_fpga_probe(struct spi_device *spi)
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 114a64d2b7a4d..8b860e9a19c92 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -350,10 +350,10 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops machxo2_ops = {
-	.state = machxo2_spi_state,
-	.write_init = machxo2_write_init,
-	.write = machxo2_write,
-	.write_complete = machxo2_write_complete,
+	.state                   = machxo2_spi_state,
+	.reconfig.write_init     = machxo2_write_init,
+	.reconfig.write          = machxo2_write,
+	.reconfig.write_complete = machxo2_write_complete,
 };
 
 static int machxo2_spi_probe(struct spi_device *spi)
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index 573d88bdf7307..e60bf844b4c40 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -458,11 +458,11 @@ static enum fpga_mgr_states socfpga_a10_fpga_state(struct fpga_manager *mgr)
 }
 
 static const struct fpga_manager_ops socfpga_a10_fpga_mgr_ops = {
-	.initial_header_size = (RBF_DECOMPRESS_OFFSET + 1) * 4,
-	.state = socfpga_a10_fpga_state,
-	.write_init = socfpga_a10_fpga_write_init,
-	.write = socfpga_a10_fpga_write,
-	.write_complete = socfpga_a10_fpga_write_complete,
+	.initial_header_size     = (RBF_DECOMPRESS_OFFSET + 1) * 4,
+	.state                   = socfpga_a10_fpga_state,
+	.reconfig.write_init     = socfpga_a10_fpga_write_init,
+	.reconfig.write          = socfpga_a10_fpga_write,
+	.reconfig.write_complete = socfpga_a10_fpga_write_complete,
 };
 
 static int socfpga_a10_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 1f467173fc1f3..cc752a3f742c2 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -534,10 +534,10 @@ static enum fpga_mgr_states socfpga_fpga_ops_state(struct fpga_manager *mgr)
 }
 
 static const struct fpga_manager_ops socfpga_fpga_ops = {
-	.state = socfpga_fpga_ops_state,
-	.write_init = socfpga_fpga_ops_configure_init,
-	.write = socfpga_fpga_ops_configure_write,
-	.write_complete = socfpga_fpga_ops_configure_complete,
+	.state                   = socfpga_fpga_ops_state,
+	.reconfig.write_init     = socfpga_fpga_ops_configure_init,
+	.reconfig.write          = socfpga_fpga_ops_configure_write,
+	.reconfig.write_complete = socfpga_fpga_ops_configure_complete,
 };
 
 static int socfpga_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 657a70c5fc996..c746a43e6438f 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -394,10 +394,10 @@ static enum fpga_mgr_states s10_ops_state(struct fpga_manager *mgr)
 }
 
 static const struct fpga_manager_ops s10_ops = {
-	.state = s10_ops_state,
-	.write_init = s10_ops_write_init,
-	.write = s10_ops_write,
-	.write_complete = s10_ops_write_complete,
+	.state                           = s10_ops_state,
+	.partial_reconfig.write_init     = s10_ops_write_init,
+	.partial_reconfig.write          = s10_ops_write,
+	.partial_reconfig.write_complete = s10_ops_write_complete,
 };
 
 static int s10_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 101f016c6ed8c..ab799aa05b9a2 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -98,10 +98,10 @@ static int ts73xx_fpga_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops ts73xx_fpga_ops = {
-	.state		= ts73xx_fpga_state,
-	.write_init	= ts73xx_fpga_write_init,
-	.write		= ts73xx_fpga_write,
-	.write_complete	= ts73xx_fpga_write_complete,
+	.state                   = ts73xx_fpga_state,
+	.reconfig.write_init     = ts73xx_fpga_write_init,
+	.reconfig.write          = ts73xx_fpga_write,
+	.reconfig.write_complete = ts73xx_fpga_write_complete,
 };
 
 static int ts73xx_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index fee4d0abf6bfe..4d092f30bf700 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -214,10 +214,10 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops xilinx_spi_ops = {
-	.state = xilinx_spi_state,
-	.write_init = xilinx_spi_write_init,
-	.write = xilinx_spi_write,
-	.write_complete = xilinx_spi_write_complete,
+	.state                   = xilinx_spi_state,
+	.reconfig.write_init     = xilinx_spi_write_init,
+	.reconfig.write          = xilinx_spi_write,
+	.reconfig.write_complete = xilinx_spi_write_complete,
 };
 
 static int xilinx_spi_probe(struct spi_device *spi)
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 07fa8d9ec6750..dde10f1ce1f57 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -543,11 +543,11 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
 }
 
 static const struct fpga_manager_ops zynq_fpga_ops = {
-	.initial_header_size = 128,
-	.state = zynq_fpga_ops_state,
-	.write_init = zynq_fpga_ops_write_init,
-	.write_sg = zynq_fpga_ops_write,
-	.write_complete = zynq_fpga_ops_write_complete,
+	.initial_header_size     = 128,
+	.state                   = zynq_fpga_ops_state,
+	.reconfig.write_init     = zynq_fpga_ops_write_init,
+	.reconfig.write_sg       = zynq_fpga_ops_write,
+	.reconfig.write_complete = zynq_fpga_ops_write_complete,
 };
 
 static int zynq_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 125743c9797ff..3bb9824a2a881 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -84,10 +84,10 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 }
 
 static const struct fpga_manager_ops zynqmp_fpga_ops = {
-	.state = zynqmp_fpga_ops_state,
-	.write_init = zynqmp_fpga_ops_write_init,
-	.write = zynqmp_fpga_ops_write,
-	.write_complete = zynqmp_fpga_ops_write_complete,
+	.state                   = zynqmp_fpga_ops_state,
+	.reconfig.write_init     = zynqmp_fpga_ops_write_init,
+	.reconfig.write          = zynqmp_fpga_ops_write,
+	.reconfig.write_complete = zynqmp_fpga_ops_write_complete,
 };
 
 static int zynqmp_fpga_probe(struct platform_device *pdev)
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 2bc3030a69e54..50a9fea3c47ef 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -106,14 +106,29 @@ struct fpga_image_info {
 };
 
 /**
- * struct fpga_manager_ops - ops for low level fpga manager drivers
- * @initial_header_size: Maximum number of bytes that should be passed into write_init
- * @state: returns an enum value of the FPGA's state
- * @status: returns status of the FPGA, including reconfiguration error code
+ * struct fpga_manager_update_ops - ops updating fpga
  * @write_init: prepare the FPGA to receive confuration data
  * @write: write count bytes of configuration data to the FPGA
  * @write_sg: write the scatter list of configuration data to the FPGA
  * @write_complete: set FPGA to operating state after writing is done
+ */
+struct fpga_manager_update_ops {
+	int (*write_init)(struct fpga_manager *mgr,
+			  struct fpga_image_info *info,
+			  const char *buf, size_t count);
+	int (*write)(struct fpga_manager *mgr, const char *buf, size_t count);
+	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
+	int (*write_complete)(struct fpga_manager *mgr,
+			      struct fpga_image_info *info);
+};
+
+/**
+ * struct fpga_manager_ops - ops for low level fpga manager drivers
+ * @initial_header_size: Maximum number of bytes that should be passed into write_init
+ * @state: returns an enum value of the FPGA's state
+ * @status: returns status of the FPGA, including reconfiguration error code
+ * @partial_update: ops for doing partial reconfiguration
+ * @full_update: ops for doing a full card update, user,shell,fw ie. the works
  * @fpga_remove: optional: Set FPGA into a specific state during driver remove
  * @groups: optional attribute groups.
  *
@@ -125,13 +140,8 @@ struct fpga_manager_ops {
 	size_t initial_header_size;
 	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
 	u64 (*status)(struct fpga_manager *mgr);
-	int (*write_init)(struct fpga_manager *mgr,
-			  struct fpga_image_info *info,
-			  const char *buf, size_t count);
-	int (*write)(struct fpga_manager *mgr, const char *buf, size_t count);
-	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
-	int (*write_complete)(struct fpga_manager *mgr,
-			      struct fpga_image_info *info);
+	struct fpga_manager_update_ops reconfig;
+	struct fpga_manager_update_ops reimage;
 	void (*fpga_remove)(struct fpga_manager *mgr);
 	const struct attribute_group **groups;
 };
-- 
2.26.3

