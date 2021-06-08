Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFECB3A04B4
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 21:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhFHT5M (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 15:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234576AbhFHT5K (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 15:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ik8JGUYI3/+hbO9x+DDmD96jPOqQ4zVk4ycCcPjNv+o=;
        b=Btq/NxzDSIAyqk9nZj/5MjApxy8iWKQ6x+S39fl+fn4aC8if9siIva49SNM3Fw+yw0Pox+
        tRGquARHP43Yr3YwUX7PVbpkbVp5jVpvQQ42hX013roj9gpIYG5RVNZtQ+tZrGZ/69597S
        rTGErVGqd42bjPfDbL4XDzsCw/4nLgw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-Wn3FvEk7OO2Rarf98-l-RQ-1; Tue, 08 Jun 2021 15:55:15 -0400
X-MC-Unique: Wn3FvEk7OO2Rarf98-l-RQ-1
Received: by mail-ot1-f72.google.com with SMTP id q20-20020a9d7c940000b02903f5a4101f8eso1848137otn.17
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 12:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ik8JGUYI3/+hbO9x+DDmD96jPOqQ4zVk4ycCcPjNv+o=;
        b=Oq9BSg4ml7x5+1N1YTwjuxyuPq8yXM4q2cLhh1KEIzQdjk2ZVmTU2xRmKnAU6PJbau
         XtLUpOoSxK+q6nOVLrFM/qGcMs7xSw8RegNWUC2Gtbe+NR8oBXz1boMuD7BHgA3h/rmn
         AqUdDGnlfmicLzGDHpPX9exbHMUD3x61BC1mgbvdlrDfiJ8Dx37QbWPF/vzX5Amh0fof
         GOUscAAXoFwbVgB6CjB2G1qTbsDooF3WZKjRY0tz6xfXzyVln0PmerNQBBDeCLaX81AT
         0P9YxThxNiEo7ahr7eKRe4jgE7xl2TClbay+nasEtTlNZcXRLXvIXE12/dQwO+61alCT
         JO3w==
X-Gm-Message-State: AOAM533DDNh4E+rGPNNAGYX1HdxKigA32dnt+Vx2UYO46NeTbS9qoTp3
        o1Fs20KG8aRxiV84jM2YIT81k2AYXM//ctRmf9C/w1C+1AXYssOS+haOB7AHMo9a09ZFirypKE6
        Cd9nt1CwBml+NS47yEDVUkg==
X-Received: by 2002:aca:1a05:: with SMTP id a5mr3820092oia.26.1623182115007;
        Tue, 08 Jun 2021 12:55:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4gcno8v2BQWArONVSZdl6j/JvTWxDq9sZDI7o76liP0AeU55RDfKdp5C+vsmCglW/+gol4w==
X-Received: by 2002:aca:1a05:: with SMTP id a5mr3820083oia.26.1623182114836;
        Tue, 08 Jun 2021 12:55:14 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:14 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 2/7] fpga-mgr: make write_complete() op optional
Date:   Tue,  8 Jun 2021 12:55:01 -0700
Message-Id: <20210608195506.3022550-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608195506.3022550-1-trix@redhat.com>
References: <20210608195506.3022550-1-trix@redhat.com>
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
index 24547e36a56d8..dadad24015020 100644
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
@@ -576,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->write_complete || !mops->state ||
+	if (!mops || !mops->state ||
 	    (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
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

