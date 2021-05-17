Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4453822CD
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 04:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhEQCeS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 May 2021 22:34:18 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:33673 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhEQCeS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 May 2021 22:34:18 -0400
Received: by mail-pj1-f41.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so3720292pjo.0
        for <linux-fpga@vger.kernel.org>; Sun, 16 May 2021 19:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+YrGzZ6MmEiwtx5btv++wc9SzwmuGUZDBQtwH1wHT74=;
        b=d3rMoty76HyEFeyQsIYqKtjLNWbOJ32gjMyIoWX9hYb/E3I8ID10X2XZdqIV+7WQBO
         hlqQUikZMRaDiT4ddZB6qKNtpBv0Aw5O0sje/K51qMmsHlm134PZ1D2FMh8TiMIPI7IS
         4Eg4FvCb9PuW9RfJw26NOLLosNAE+FWNiwQLRltZ7bLHSz8r2u7Rw6nBlbB389m6Yipt
         nw457x0PmlWnSEVBjUWFQvnNxR7Q6y6fZdGS1kM+KeSwuf5fwizKSd+mIAMhmTcIoFPR
         eIXGZ1HqH2Cd4olbYdvrIY78UdeHoeX68/sGiRLf0t1m+pu5miCTwW4aOU54gMAMJdy9
         KrOg==
X-Gm-Message-State: AOAM530XqiS2LUVMSwQvEGGXvGHSri+Yv/lVuzfdxkR42BzfHghPoAgI
        EOFf3NdAtykRQCs/ct2hDIM=
X-Google-Smtp-Source: ABdhPJzYln4uJOync0CY3rC7qNIq9+FjrVS1f6tH3kxxcp4PxJ5olpwYhGMyIiHs7djNTnrDpdiyWA==
X-Received: by 2002:a17:902:a58b:b029:ee:d13a:2642 with SMTP id az11-20020a170902a58bb02900eed13a2642mr58095628plb.35.1621218782409;
        Sun, 16 May 2021 19:33:02 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id b12sm5436327pgs.52.2021.05.16.19.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:33:01 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH 11/12] fpga: m10bmc-sec: add max10 secure update functions
Date:   Sun, 16 May 2021 19:31:59 -0700
Message-Id: <20210517023200.52707-12-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517023200.52707-1-mdf@kernel.org>
References: <20210517023200.52707-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Extend the MAX10 BMC Secure Update driver to include
the functions that enable secure updates of BMC images,
FPGA images, etc.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/intel-m10-bmc-secure.c | 310 +++++++++++++++++++++++++++-
 1 file changed, 309 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 87e16c146569..9d45312001a3 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -180,7 +180,315 @@ static const struct attribute_group *m10bmc_sec_attr_groups[] = {
 	NULL,
 };
 
-static const struct fpga_sec_mgr_ops m10bmc_sops = { };
+static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
+{
+	u32 auth_result;
+
+	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
+
+	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
+		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
+}
+
+static enum fpga_sec_err rsu_check_idle(struct m10bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return FPGA_SEC_ERR_RW_ERROR;
+
+	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
+	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_BUSY;
+	}
+
+	return FPGA_SEC_ERR_NONE;
+}
+
+static inline bool rsu_start_done(u32 doorbell)
+{
+	u32 status, progress;
+
+	if (doorbell & DRBL_RSU_REQUEST)
+		return false;
+
+	status = rsu_stat(doorbell);
+	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
+		return true;
+
+	progress = rsu_prog(doorbell);
+	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
+		return true;
+
+	return false;
+}
+
+static enum fpga_sec_err rsu_update_init(struct m10bmc_sec *sec)
+{
+	u32 doorbell, status;
+	int ret;
+
+	ret = regmap_update_bits(sec->m10bmc->regmap,
+				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
+				 DRBL_RSU_REQUEST |
+				 FIELD_PREP(DRBL_HOST_STATUS,
+					    HOST_STATUS_IDLE));
+	if (ret)
+		return FPGA_SEC_ERR_RW_ERROR;
+
+	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       doorbell,
+				       rsu_start_done(doorbell),
+				       NIOS_HANDSHAKE_INTERVAL_US,
+				       NIOS_HANDSHAKE_TIMEOUT_US);
+
+	if (ret == -ETIMEDOUT) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_TIMEOUT;
+	} else if (ret) {
+		return FPGA_SEC_ERR_RW_ERROR;
+	}
+
+	status = rsu_stat(doorbell);
+	if (status == RSU_STAT_WEAROUT) {
+		dev_warn(sec->dev, "Excessive flash update count detected\n");
+		return FPGA_SEC_ERR_WEAROUT;
+	} else if (status == RSU_STAT_ERASE_FAIL) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return FPGA_SEC_ERR_NONE;
+}
+
+static enum fpga_sec_err rsu_prog_ready(struct m10bmc_sec *sec)
+{
+	unsigned long poll_timeout;
+	u32 doorbell, progress;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return FPGA_SEC_ERR_RW_ERROR;
+
+	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
+	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
+		msleep(RSU_PREP_INTERVAL_MS);
+		if (time_after(jiffies, poll_timeout))
+			break;
+
+		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+		if (ret)
+			return FPGA_SEC_ERR_RW_ERROR;
+	}
+
+	progress = rsu_prog(doorbell);
+	if (progress == RSU_PROG_PREPARE) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_TIMEOUT;
+	} else if (progress != RSU_PROG_READY) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return FPGA_SEC_ERR_NONE;
+}
+
+static enum fpga_sec_err rsu_send_data(struct m10bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = regmap_update_bits(sec->m10bmc->regmap,
+				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 DRBL_HOST_STATUS,
+				 FIELD_PREP(DRBL_HOST_STATUS,
+					    HOST_STATUS_WRITE_DONE));
+	if (ret)
+		return FPGA_SEC_ERR_RW_ERROR;
+
+	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       doorbell,
+				       rsu_prog(doorbell) != RSU_PROG_READY,
+				       NIOS_HANDSHAKE_INTERVAL_US,
+				       NIOS_HANDSHAKE_TIMEOUT_US);
+
+	if (ret == -ETIMEDOUT) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_TIMEOUT;
+	} else if (ret) {
+		return FPGA_SEC_ERR_RW_ERROR;
+	}
+
+	switch (rsu_stat(doorbell)) {
+	case RSU_STAT_NORMAL:
+	case RSU_STAT_NIOS_OK:
+	case RSU_STAT_USER_OK:
+	case RSU_STAT_FACTORY_OK:
+		break;
+	default:
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return FPGA_SEC_ERR_NONE;
+}
+
+static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
+{
+	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
+		return -EIO;
+
+	switch (rsu_stat(*doorbell)) {
+	case RSU_STAT_NORMAL:
+	case RSU_STAT_NIOS_OK:
+	case RSU_STAT_USER_OK:
+	case RSU_STAT_FACTORY_OK:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (rsu_prog(*doorbell)) {
+	case RSU_PROG_IDLE:
+	case RSU_PROG_RSU_DONE:
+		return 0;
+	case RSU_PROG_AUTHENTICATING:
+	case RSU_PROG_COPYING:
+	case RSU_PROG_UPDATE_CANCEL:
+	case RSU_PROG_PROGRAM_KEY_HASH:
+		return -EAGAIN;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum fpga_sec_err m10bmc_sec_prepare(struct fpga_sec_mgr *smgr)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	enum fpga_sec_err ret;
+
+	if (smgr->remaining_size > M10BMC_STAGING_SIZE)
+		return FPGA_SEC_ERR_INVALID_SIZE;
+
+	ret = rsu_check_idle(sec);
+	if (ret != FPGA_SEC_ERR_NONE)
+		return ret;
+
+	ret = rsu_update_init(sec);
+	if (ret != FPGA_SEC_ERR_NONE)
+		return ret;
+
+	return rsu_prog_ready(sec);
+}
+
+#define WRITE_BLOCK_SIZE 0x4000 /* Update remaining_size every 0x4000 bytes */
+
+static enum fpga_sec_err
+m10bmc_sec_write_blk(struct fpga_sec_mgr *smgr, u32 offset)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	u32 doorbell, blk_size;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret) {
+		return FPGA_SEC_ERR_RW_ERROR;
+	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_HW_ERROR;
+	}
+
+	blk_size = min_t(u32, smgr->remaining_size, WRITE_BLOCK_SIZE);
+	ret = regmap_bulk_write(sec->m10bmc->regmap,
+				M10BMC_STAGING_BASE + offset,
+				(void *)smgr->data + offset,
+				(blk_size + stride - 1) / stride);
+
+	if (ret)
+		return FPGA_SEC_ERR_RW_ERROR;
+
+	smgr->remaining_size -= blk_size;
+	return FPGA_SEC_ERR_NONE;
+}
+
+/*
+ * m10bmc_sec_poll_complete() is called after handing things off to
+ * the BMC firmware. Depending on the type of update, it could be
+ * 30+ minutes before the BMC firmware completes the update. The
+ * smgr->driver_unload check allows the driver to be unloaded,
+ * but the BMC firmware will continue the update and no further
+ * secure updates can be started for this device until the update
+ * is complete.
+ */
+static enum fpga_sec_err m10bmc_sec_poll_complete(struct fpga_sec_mgr *smgr)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	unsigned long poll_timeout;
+	enum fpga_sec_err result;
+	u32 doorbell;
+	int ret;
+
+	result = rsu_send_data(sec);
+	if (result != FPGA_SEC_ERR_NONE)
+		return result;
+
+	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
+	do {
+		msleep(RSU_COMPLETE_INTERVAL_MS);
+		ret = rsu_check_complete(sec, &doorbell);
+		if (smgr->driver_unload)
+			return FPGA_SEC_ERR_CANCELED;
+	} while (ret == -EAGAIN && !time_after(jiffies, poll_timeout));
+
+	if (ret == -EAGAIN) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_TIMEOUT;
+	} else if (ret == -EIO) {
+		return FPGA_SEC_ERR_RW_ERROR;
+	} else if (ret) {
+		log_error_regs(sec, doorbell);
+		return FPGA_SEC_ERR_HW_ERROR;
+	}
+
+	return FPGA_SEC_ERR_NONE;
+}
+
+static enum fpga_sec_err m10bmc_sec_cancel(struct fpga_sec_mgr *smgr)
+{
+	struct m10bmc_sec *sec = smgr->priv;
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return FPGA_SEC_ERR_RW_ERROR;
+
+	if (rsu_prog(doorbell) != RSU_PROG_READY)
+		return FPGA_SEC_ERR_BUSY;
+
+	ret = regmap_update_bits(sec->m10bmc->regmap,
+				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 DRBL_HOST_STATUS,
+				 FIELD_PREP(DRBL_HOST_STATUS,
+					    HOST_STATUS_ABORT_RSU));
+
+	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
+}
+
+static const struct fpga_sec_mgr_ops m10bmc_sops = {
+	.prepare = m10bmc_sec_prepare,
+	.write_blk = m10bmc_sec_write_blk,
+	.poll_complete = m10bmc_sec_poll_complete,
+	.cancel = m10bmc_sec_cancel,
+};
 
 static int m10bmc_secure_probe(struct platform_device *pdev)
 {
-- 
2.31.1

