Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF1389828
	for <lists+linux-fpga@lfdr.de>; Wed, 19 May 2021 22:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhESUoZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 May 2021 16:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhESUoY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 19 May 2021 16:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621456984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZuFtfWXXiGzws9aQIqYrC67/CSxQ4w0n/vwtJ1KfrnQ=;
        b=W82RO5mr3C4HXzr1+YfwPytKpHHJVxEB7kLqXWzmDbWWF3prKXBy/fRmsQuDFA7qukyFfS
        WpKUwBf8rWTSz/0QreV3ci6emR3SzP1MO0cdE7bmCjA5lQY13XHHazixmBYqYP92TLz7j7
        Q9rUHI7NqBKspMLAyDUa84PKqxDhd7o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-fAfdxOnyPf2YCZkkVXpR7Q-1; Wed, 19 May 2021 16:43:02 -0400
X-MC-Unique: fAfdxOnyPf2YCZkkVXpR7Q-1
Received: by mail-qk1-f199.google.com with SMTP id s10-20020a05620a030ab02902e061a1661fso4271987qkm.12
        for <linux-fpga@vger.kernel.org>; Wed, 19 May 2021 13:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZuFtfWXXiGzws9aQIqYrC67/CSxQ4w0n/vwtJ1KfrnQ=;
        b=gMLrq1l2CyskZ+kpIcyh5bmzGiNA/rsouJxQpB3NamlzQ41rRUuoRUBG4n/ggWKXPn
         t+zFzxCtpjaOwLaf1VYb29jCFKaem89k8hBXoyAmi4MD283ch0qob9N043M+jCdlcM9X
         fHHXZI5Pbngiy/FdmTnYFe2xIt6fLuGsqRt7kir8wVBWs/jTBqoCX+nrimBAn8wYbmyk
         u4vBlZwOelfwjSh1kp/m/R/xHxKsJyWYnY7oWdUYasCIPbuY90hDDh9Vx6Y+1HdK0wKY
         Xf6hfihN68VAcboQO9sjhqgqAU0YBic5cVNCRj7gB7F4ktd+6jbJNR6kXyimArGmo/6D
         bKAQ==
X-Gm-Message-State: AOAM533VYQ2tpncLtyUevCEgOCrIEDHCKG5A+axyZbAwtx5PmKWFOfml
        1SrvmvrUMgmF1LohnoXLALylz4RFo3yvucRNz8vWP+R6Cm7Sq396sNrODgWHDt/rMd+y66KjoJF
        sleEwyoADm5eRUfMGmk0TEw==
X-Received: by 2002:ac8:65d8:: with SMTP id t24mr1585459qto.332.1621456981226;
        Wed, 19 May 2021 13:43:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiMNJpn7sKIdbn/Q0+MN4ihM6/Fz3xCvaujadpb3hI1pDh7CzJGFGjO1dOwzMuhSjJehdvhQ==
X-Received: by 2002:ac8:65d8:: with SMTP id t24mr1585437qto.332.1621456980957;
        Wed, 19 May 2021 13:43:00 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e5sm421044qtg.96.2021.05.19.13.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:43:00 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 1/2] fpga: generalize updating to partial and full
Date:   Wed, 19 May 2021 13:42:56 -0700
Message-Id: <20210519204256.1975957-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

There is a need to update the whole card.
The user area, the shell and even the card firmware.
This needs to be handled differently than the
existing partial updating in the fpga manager.

Move the write_* ops out of fpga_manager_ops and
into a new fpga_manager_update_ops struct.  Add
two update_ops back to fpga_manager_ops,
partial_update for the exiting functionality and
full_update for the new functionity.

Rewire fpga devs to use new partial_update ops

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
 drivers/fpga/xilinx-spi.c        |  8 ++++----
 drivers/fpga/zynq-fpga.c         | 10 +++++-----
 drivers/fpga/zynqmp-fpga.c       |  8 ++++----
 include/linux/fpga/fpga-mgr.h    | 32 +++++++++++++++++++++-----------
 13 files changed, 80 insertions(+), 69 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4e0edb60bfba6..f90126ffd6c62 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -516,10 +516,10 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops altera_cvp_ops = {
-	.state		= altera_cvp_state,
-	.write_init	= altera_cvp_write_init,
-	.write		= altera_cvp_write,
-	.write_complete	= altera_cvp_write_complete,
+	.state                         = altera_cvp_state,
+	.partial_update.write_init     = altera_cvp_write_init,
+	.partial_update.write          = altera_cvp_write,
+	.partial_update.write_complete = altera_cvp_write_complete,
 };
 
 static const struct cvp_priv cvp_priv_v1 = {
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index 5b130c4d98829..bd2c1470d1712 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -167,10 +167,10 @@ static int alt_pr_fpga_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops alt_pr_ops = {
-	.state = alt_pr_fpga_state,
-	.write_init = alt_pr_fpga_write_init,
-	.write = alt_pr_fpga_write,
-	.write_complete = alt_pr_fpga_write_complete,
+	.state                         = alt_pr_fpga_state,
+	.partial_update.write_init     = alt_pr_fpga_write_init,
+	.partial_update.write          = alt_pr_fpga_write,
+	.partial_update.write_complete = alt_pr_fpga_write_complete,
 };
 
 int alt_pr_register(struct device *dev, void __iomem *reg_base)
diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 23bfd4d1ad0f7..80699d23a4fa8 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -231,10 +231,10 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops altera_ps_ops = {
-	.state = altera_ps_state,
-	.write_init = altera_ps_write_init,
-	.write = altera_ps_write,
-	.write_complete = altera_ps_write_complete,
+	.state                         = altera_ps_state,
+	.partial_update.write_init     = altera_ps_write_init,
+	.partial_update.write          = altera_ps_write,
+	.partial_update.write_complete = altera_ps_write_complete,
 };
 
 static const struct altera_ps_data *id_to_data(const struct spi_device_id *id)
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index d5861d13b3069..9772b0c239072 100644
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
+	.state                         = fme_mgr_state,
+	.status                        = fme_mgr_status,
+	.partial_update.write_init     = fme_mgr_write_init,
+	.partial_update.write          = fme_mgr_write,
+	.partial_update.write_complete = fme_mgr_write_complete,
 };
 
 static void fme_mgr_get_compat_id(void __iomem *fme_pr,
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index b85bc47c91a9a..969dd400410c9 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -83,9 +83,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 	if (!mgr->mops->initial_header_size)
-		ret = mgr->mops->write_init(mgr, info, NULL, 0);
+		ret = mgr->mops->partial_update.write_init(mgr, info, NULL, 0);
 	else
-		ret = mgr->mops->write_init(
+		ret = mgr->mops->partial_update.write_init(
 		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
 
 	if (ret) {
@@ -147,7 +147,7 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	ret = mgr->mops->write_complete(mgr, info);
+	ret = mgr->mops->partial_update.write_complete(mgr, info);
 	if (ret) {
 		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
@@ -187,14 +187,14 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 
 	/* Write the FPGA image to the FPGA. */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	if (mgr->mops->write_sg) {
-		ret = mgr->mops->write_sg(mgr, sgt);
+	if (mgr->mops->partial_update.write_sg) {
+		ret = mgr->mops->partial_update.write_sg(mgr, sgt);
 	} else {
 		struct sg_mapping_iter miter;
 
 		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter)) {
-			ret = mgr->mops->write(mgr, miter.addr, miter.length);
+			ret = mgr->mops->partial_update.write(mgr, miter.addr, miter.length);
 			if (ret)
 				break;
 		}
@@ -224,7 +224,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	 * Write the FPGA image to the FPGA.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	ret = mgr->mops->write(mgr, buf, count);
+	ret = mgr->mops->partial_update.write(mgr, buf, count);
 	if (ret) {
 		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
@@ -264,7 +264,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
 	 * contiguous kernel buffer and the driver doesn't require SG, non-SG
 	 * drivers will still work on the slow path.
 	 */
-	if (mgr->mops->write)
+	if (mgr->mops->partial_update.write)
 		return fpga_mgr_buf_load_mapped(mgr, info, buf, count);
 
 	/*
@@ -568,9 +568,10 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->write_complete || !mops->state ||
-	    !mops->write_init || (!mops->write && !mops->write_sg) ||
-	    (mops->write && mops->write_sg)) {
+	if (!mops || !mops->partial_update.write_complete || !mops->state ||
+	    !mops->partial_update.write_init || (!mops->partial_update.write &&
+						 !mops->partial_update.write_sg) ||
+	    (mops->partial_update.write && mops->partial_update.write_sg)) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 69dec5af23c36..e6a7424e937b0 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -126,10 +126,10 @@ static int ice40_fpga_ops_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops ice40_fpga_ops = {
-	.state = ice40_fpga_ops_state,
-	.write_init = ice40_fpga_ops_write_init,
-	.write = ice40_fpga_ops_write,
-	.write_complete = ice40_fpga_ops_write_complete,
+	.state                         = ice40_fpga_ops_state,
+	.partial_update.write_init     = ice40_fpga_ops_write_init,
+	.partial_update.write          = ice40_fpga_ops_write,
+	.partial_update.write_complete = ice40_fpga_ops_write_complete,
 };
 
 static int ice40_fpga_probe(struct spi_device *spi)
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 114a64d2b7a4d..2b4e828e5f000 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -350,10 +350,10 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops machxo2_ops = {
-	.state = machxo2_spi_state,
-	.write_init = machxo2_write_init,
-	.write = machxo2_write,
-	.write_complete = machxo2_write_complete,
+	.state                         = machxo2_spi_state,
+	.partial_update.write_init     = machxo2_write_init,
+	.partial_update.write          = machxo2_write,
+	.partial_update.write_complete = machxo2_write_complete,
 };
 
 static int machxo2_spi_probe(struct spi_device *spi)
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index 573d88bdf7307..1479a16c027d5 100644
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
+	.initial_header_size           = (RBF_DECOMPRESS_OFFSET + 1) * 4,
+	.state                         = socfpga_a10_fpga_state,
+	.partial_update.write_init     = socfpga_a10_fpga_write_init,
+	.partial_update.write          = socfpga_a10_fpga_write,
+	.partial_update.write_complete = socfpga_a10_fpga_write_complete,
 };
 
 static int socfpga_a10_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 1f467173fc1f3..ac369921d0bb2 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -534,10 +534,10 @@ static enum fpga_mgr_states socfpga_fpga_ops_state(struct fpga_manager *mgr)
 }
 
 static const struct fpga_manager_ops socfpga_fpga_ops = {
-	.state = socfpga_fpga_ops_state,
-	.write_init = socfpga_fpga_ops_configure_init,
-	.write = socfpga_fpga_ops_configure_write,
-	.write_complete = socfpga_fpga_ops_configure_complete,
+	.state                         = socfpga_fpga_ops_state,
+	.partial_update.write_init     = socfpga_fpga_ops_configure_init,
+	.partial_update.write          = socfpga_fpga_ops_configure_write,
+	.partial_update.write_complete = socfpga_fpga_ops_configure_complete,
 };
 
 static int socfpga_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index fee4d0abf6bfe..269af904f8057 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -214,10 +214,10 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops xilinx_spi_ops = {
-	.state = xilinx_spi_state,
-	.write_init = xilinx_spi_write_init,
-	.write = xilinx_spi_write,
-	.write_complete = xilinx_spi_write_complete,
+	.state                         = xilinx_spi_state,
+	.partial_update.write_init     = xilinx_spi_write_init,
+	.partial_update.write          = xilinx_spi_write,
+	.partial_update.write_complete = xilinx_spi_write_complete,
 };
 
 static int xilinx_spi_probe(struct spi_device *spi)
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 07fa8d9ec6750..160f529cd12e6 100644
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
+	.initial_header_size           = 128,
+	.state                         = zynq_fpga_ops_state,
+	.partial_update.write_init     = zynq_fpga_ops_write_init,
+	.partial_update.write_sg       = zynq_fpga_ops_write,
+	.partial_update.write_complete = zynq_fpga_ops_write_complete,
 };
 
 static int zynq_fpga_probe(struct platform_device *pdev)
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 125743c9797ff..de77b8b2fb028 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -84,10 +84,10 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 }
 
 static const struct fpga_manager_ops zynqmp_fpga_ops = {
-	.state = zynqmp_fpga_ops_state,
-	.write_init = zynqmp_fpga_ops_write_init,
-	.write = zynqmp_fpga_ops_write,
-	.write_complete = zynqmp_fpga_ops_write_complete,
+	.state                         = zynqmp_fpga_ops_state,
+	.partial_update.write_init     = zynqmp_fpga_ops_write_init,
+	.partial_update.write          = zynqmp_fpga_ops_write,
+	.partial_update.write_complete = zynqmp_fpga_ops_write_complete,
 };
 
 static int zynqmp_fpga_probe(struct platform_device *pdev)
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 2bc3030a69e54..ab68280f3b4a4 100644
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
+	struct fpga_manager_update_ops partial_update;
+	struct fpga_manager_update_ops full_update;
 	void (*fpga_remove)(struct fpga_manager *mgr);
 	const struct attribute_group **groups;
 };
-- 
2.26.3

