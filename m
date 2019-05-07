Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D67416B96
	for <lists+linux-fpga@lfdr.de>; Tue,  7 May 2019 21:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfEGTnc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 May 2019 15:43:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38283 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEGTnc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 May 2019 15:43:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so8824289pgl.5
        for <linux-fpga@vger.kernel.org>; Tue, 07 May 2019 12:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ewkuTpRG7XAqOKCyoArod5p1Qyn37L7LNzmlcvLqB88=;
        b=KlzbUpcV6FQwkTCd3j0PGbXS+2oyOzCznbCQP/3ywg3EzYHcd5CcwkjGFDCYG3gZey
         9cldbjDuF/I++lGTdLkl6eAKSh879RDfWQmsQSnPpUeUcj4nPOVwQXIYvXoJfLSAj1uT
         /EnnmI5RAxva2xEO2a2kwMsLrqdRBcWVBwB8iRSVfwR+u1TLz02eODfb4bbbxfHm+lrb
         +6to9ctIMgGFndLbdBksESSGFnBCKkvpi0mjysTP/duLMPDyo8FhT36kf37/QQbeitQP
         e6/+3WYG6uanKZnk0++2rbLMcXHHiumyie9KlPqZ2pDGkHaonrSebEvwQd3q1UmZTvX4
         4K6g==
X-Gm-Message-State: APjAAAW+l9p6UM4apd2UJxXH89bRqYgNCeLdr7SWGnqYc0PRzCaGcCuk
        lZ7u5zgQJEaug4pVlF5ME5q7jQx3Sf0etA==
X-Google-Smtp-Source: APXvYqzBkEu3Inaaw5RJcp14jDR73QiaQstLX9sXE/2auF/4QH+BQhdInVPnwxoNgO9g7hlwJL4HxQ==
X-Received: by 2002:a62:e50a:: with SMTP id n10mr43912680pff.55.1557258210936;
        Tue, 07 May 2019 12:43:30 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id s79sm31216845pfa.31.2019.05.07.12.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 12:43:29 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     atull@kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        Moritz Fischer <mdf@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] fpga: zynqmp-fpga: Correctly handle error pointer
Date:   Tue,  7 May 2019 12:43:13 -0700
Message-Id: <20190507194313.1618-1-mdf@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fixes the following static checker errors:

drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
error: 'eemi_ops' dereferencing possible ERR_PTR()

drivers/fpga/zynqmp-fpga.c:84 zynqmp_fpga_ops_state()
error: 'eemi_ops' dereferencing possible ERR_PTR()

Note: This does not handle the EPROBE_DEFER value in a
      special manner.

Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
Xilinx zynqmp")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from v1:
- Address Alan's feedback regarding handling both occurences.

---
 drivers/fpga/zynqmp-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index f7cbaadf49ab..b8a88d21d038 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 	char *kbuf;
 	int ret;
 
-	if (!eemi_ops || !eemi_ops->fpga_load)
+	if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
 		return -ENXIO;
 
 	priv = mgr->priv;
@@ -81,7 +81,7 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	u32 status;
 
-	if (!eemi_ops || !eemi_ops->fpga_get_status)
+	if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_get_status)
 		return FPGA_MGR_STATE_UNKNOWN;
 
 	eemi_ops->fpga_get_status(&status);
-- 
2.21.0

