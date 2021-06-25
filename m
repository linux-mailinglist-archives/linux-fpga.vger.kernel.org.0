Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ECD3B4969
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFYTyo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 15:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230025AbhFYTyn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 15:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624650741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4aYp4hJz/EjjMi3xPniOC0g0VH/UB+PZgaBhiQVtvD8=;
        b=BqH653PKyq0iNNLLhK9q4nM0xF9m4J+pZScFsx+sTQ6UsbVdiKfqi1NVHjCJNVlls9N27R
        a9nHW13/tQE94R6jYedKRlz3mcSI2MjvKejU/AvDhFaE7g2rU1jvmNeY8B8kivzCiKa3r9
        xKB3fz2kQVaOQGcW/q6sja1Cw1HPfao=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-d-UaBtudMK2QO0Np-0cdWQ-1; Fri, 25 Jun 2021 15:52:20 -0400
X-MC-Unique: d-UaBtudMK2QO0Np-0cdWQ-1
Received: by mail-oi1-f197.google.com with SMTP id t22-20020a0568081596b029023a41b03dc9so5279270oiw.1
        for <linux-fpga@vger.kernel.org>; Fri, 25 Jun 2021 12:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aYp4hJz/EjjMi3xPniOC0g0VH/UB+PZgaBhiQVtvD8=;
        b=QRywNO0K8o5zIpKXYCR7H65rL4IRUUaS9mI43DWb64wKRzByCMq/u5JSH1AtZtYdlU
         9jDuI2V045nNlkoaU2SDWsOflNgxOlRx42ybiwQ9QC4rWnj62bVClie4BkHe5oKHodMx
         06/6LK/voekEgNBx1QIWrB3tB05RX5z8CwYvbn093imcVThULZpoUufXpU9cYURQeonC
         /Nc+lG3voTEER2zUmVUkHTy+CpYjZGGri9YGOrwh8BXm34DersQzU652Sd2dvGi0Ywv7
         iHuKRq+TiHSbiRGUNJwDWwQHqEvqA0fCjEpuq2dlAYU8qjDdhqV6YvOSuWFE/W2RFEyK
         TyKg==
X-Gm-Message-State: AOAM530Rllv4uJ7D1tP0iYQTuCjc25OmN9DPAzaHFXNUNbXyBXsOmz3V
        lSejXxBmQIjjrkj3GH4sciklxBUa87HpabYQ0Mg9se05iIL0edKfbUi2FlL2FmwqeqvsXvLLWy4
        O6NDBPBjrO76896hJ1oaC8w==
X-Received: by 2002:a05:6808:bc1:: with SMTP id o1mr12878395oik.176.1624650739896;
        Fri, 25 Jun 2021 12:52:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypIr38r6Xwat7SHOutFdWdtMBZB5yIHYyEpbFVr7YNiZOiaRsU1APN36mLAM8st0Os4NeZUA==
X-Received: by 2002:a05:6808:bc1:: with SMTP id o1mr12878390oik.176.1624650739792;
        Fri, 25 Jun 2021 12:52:19 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm1535446ood.20.2021.06.25.12.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:52:19 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 7/7] fpga-mgr: wrap the write_sg() op
Date:   Fri, 25 Jun 2021 12:51:48 -0700
Message-Id: <20210625195148.837230-9-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195148.837230-1-trix@redhat.com>
References: <20210625195148.837230-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager should not be required to provide a
write_sg function. Move the op check to the wrapper.
Default to -EOPNOTSUP so its users will fail
gracefully.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 077c0f9edbe4c..aa30889e23208 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -83,6 +83,14 @@ static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
 	return 0;
 }
 
+static inline int fpga_mgr_write_sg(struct fpga_manager *mgr,
+				    struct sg_table *sgt)
+{
+	if (mgr->mops->write_sg)
+		return  mgr->mops->write_sg(mgr, sgt);
+	return -EOPNOTSUPP;
+}
+
 /**
  * fpga_image_info_alloc - Allocate an FPGA image info struct
  * @dev: owning device
@@ -225,7 +233,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 	/* Write the FPGA image to the FPGA. */
 	mgr->state = FPGA_MGR_STATE_WRITE;
 	if (mgr->mops->write_sg) {
-		ret = mgr->mops->write_sg(mgr, sgt);
+		ret = fpga_mgr_write_sg(mgr, sgt);
 	} else {
 		struct sg_mapping_iter miter;
 
-- 
2.26.3

