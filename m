Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69623B2036
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFWS0t (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Jun 2021 14:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhFWS0t (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Jun 2021 14:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5PxTldx17CDNKsCv+3pIoboW0CCoBJIoZzyWzxD7ju4=;
        b=fLT8U6ZvCxrbi/jB4snTIsHAouKXowlB5mPWejH6a2fgGP4t0MPKh25IMeZZR/SnCIMtVW
        utk4YFe49xhxJLrNBXcb9ZbDtpAtnlilbSsBD4GbO+Cb0GxnUFZVzIGfKOvXOlzy/4wsly
        oZkG3jGbJu2gXQQUOntX5r6iIpBR840=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-Zy60hyh8P6uHryOotgAv8w-1; Wed, 23 Jun 2021 14:24:29 -0400
X-MC-Unique: Zy60hyh8P6uHryOotgAv8w-1
Received: by mail-ot1-f69.google.com with SMTP id e14-20020a0568301f2eb0290405cba3beedso1812627oth.13
        for <linux-fpga@vger.kernel.org>; Wed, 23 Jun 2021 11:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PxTldx17CDNKsCv+3pIoboW0CCoBJIoZzyWzxD7ju4=;
        b=n49nJhSZTSshIyF0K2iGMiipj+WghXCxg6WXTKPXE3lZCy7FcCK3wJVukZP6qndHoH
         /DzBn0dK0dls4TIrMb3pzRj6n6oXLOA4O19jYainwNH8jNX0qZ82XeIfA3YkJoVjvGkI
         lblocL7+Lrg/XkxRkzdRMAoiv1qcFgkonQHpibjDX1gogCQOPmxQJ57rgBQFcdou4Y9i
         zID2zQUQQCVzF9iqxNcigqtzx6ncY5TIHEiEfQcBtGuwr+ixgpPAaJ+o1iPV0x3ASCZi
         QW0B6wVWdqVh8UlefVRr5lhrXYvj344ZEsneYQRyrbZhJjpOc7iHNZr7+YTcnmNQ4INZ
         SmiQ==
X-Gm-Message-State: AOAM5306zK5G3pafpK5zCrvIi41lUQG2gHFJxe3C+o5hFNPiDq5q1bVa
        EXN3j7H7dXB9U8FWasCu3k2qNge5rJ1LXS/3cSy9yWyz76WNX2PDB/DzMAlMqn0TeB0+f2AANOY
        vpV2vAtiDuJAHshqYq5JDpg==
X-Received: by 2002:a9d:6508:: with SMTP id i8mr1032023otl.368.1624472668640;
        Wed, 23 Jun 2021 11:24:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCRjF7FYY/2Pj0Mk+PNxI071W5obXDGwdzCI4+olhtl6o/gohgN6WImevV4bHQSOtf0rG6uA==
X-Received: by 2002:a9d:6508:: with SMTP id i8mr1032007otl.368.1624472668467;
        Wed, 23 Jun 2021 11:24:28 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:28 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 2/7] fpga-mgr: make write_complete() op optional
Date:   Wed, 23 Jun 2021 11:24:05 -0700
Message-Id: <20210623182410.3787784-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623182410.3787784-1-trix@redhat.com>
References: <20210623182410.3787784-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager should not be required to provide a
write_complete function if there is nothing.  Move
the op check to the existing wrapper.
Default to success.
Remove noop function.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c    | 7 ++++---
 drivers/fpga/zynqmp-fpga.c | 7 -------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 87bbb940c9504..1c2cce1320367 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -152,10 +152,11 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 static int fpga_mgr_write_complete(struct fpga_manager *mgr,
 				   struct fpga_image_info *info)
 {
-	int ret;
+	int ret = 0;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	ret = mgr->mops->write_complete(mgr, info);
+	if (mgr->mops && mgr->mops->write_complete)
+		ret = mgr->mops->write_complete(mgr, info);
 	if (ret) {
 		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
@@ -576,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->write_complete || !mops->state ||
+	if (!mops || !mops->state ||
 	    (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 125743c9797ff..9efbd70aa6864 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -66,12 +66,6 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 	return ret;
 }
 
-static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
-					  struct fpga_image_info *info)
-{
-	return 0;
-}
-
 static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 {
 	u32 status = 0;
@@ -87,7 +81,6 @@ static const struct fpga_manager_ops zynqmp_fpga_ops = {
 	.state = zynqmp_fpga_ops_state,
 	.write_init = zynqmp_fpga_ops_write_init,
 	.write = zynqmp_fpga_ops_write,
-	.write_complete = zynqmp_fpga_ops_write_complete,
 };
 
 static int zynqmp_fpga_probe(struct platform_device *pdev)
-- 
2.26.3

