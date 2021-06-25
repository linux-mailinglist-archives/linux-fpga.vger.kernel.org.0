Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABEB3B4960
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 21:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFYTy3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 15:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhFYTy3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 15:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624650728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DrGKCk1PyABrk56DLPAvdbVVOLwe1RJgwvPdYUZWO0=;
        b=Q+aXLhLU/aZi1+4DccLUE/CZ3nx3y43qvvLFSmSQ7Vu7LAQvgMDpcAPdM4XqcQBxIJiYqk
        nJ4hXfNiHjhT2uUtUyr+gJTu/bVHgdia18kc2OfGSqe11m+Zcpn1UZTJD+/M7uFrRxeCB3
        hjb2gl/ltr7dYlfa0/Klg5+aKjTxf1M=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-OJV5fvbGP1mFKkIJTIZNaQ-1; Fri, 25 Jun 2021 15:52:06 -0400
X-MC-Unique: OJV5fvbGP1mFKkIJTIZNaQ-1
Received: by mail-oi1-f199.google.com with SMTP id 7-20020aca0f070000b029023d769dcb9bso3039732oip.14
        for <linux-fpga@vger.kernel.org>; Fri, 25 Jun 2021 12:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DrGKCk1PyABrk56DLPAvdbVVOLwe1RJgwvPdYUZWO0=;
        b=uS1qIxZx2LIv1Laovk9iEvU+zR6VQ1Za/AvDA2xCVr6pDF6oMuzetLzWK0UhvKHAzW
         0vcVmeorc/NQCgNryQNhVydcPzA2NbedqjzLyjY5ovzo9764aeRWtluu5lxVhDc0ldlA
         Z69CTNkb2ZoNVhEG9FrG7Uudy9IGd5anjWBV4eMIUj7MO7AC0/hQ3vBMTByODxo6d59G
         GyDtvtSdMtfEOofabLXdjostczmqrtBBtDGXsbERY1zcvFM/t+3LEDnVgWRW2d6CcdhI
         t7TDb17N4GS8VsUzQpGMf6VvAIHm04A0f0MZInjGX1DMcQlJcRjJ1Y0i94jzYN211z3M
         5Xcw==
X-Gm-Message-State: AOAM532bciY3HMwqLgYd/u7+1JNLiXzNdrnnWbNHpt04FYntXsPc0t4e
        oWEszFno2bGlnI4vPS1C1KlMCyQZ12WgZDWbEGNREG0ri8SElnFZEyBDAeOPnAI6UqMfWsgB0MG
        sezi8MPYZwXZ/KzCFvyU71A==
X-Received: by 2002:aca:de07:: with SMTP id v7mr12660081oig.8.1624650725834;
        Fri, 25 Jun 2021 12:52:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwksAeBpoAvEUezEdyZ5NcQyipuc4+d8PdYoULnG6dzFZDi28TVoKaNvmx21VMJfDFVEgV/4A==
X-Received: by 2002:aca:de07:: with SMTP id v7mr12660075oig.8.1624650725709;
        Fri, 25 Jun 2021 12:52:05 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm1535446ood.20.2021.06.25.12.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:52:05 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 1/7] fpga-mgr: wrap the write_init() op
Date:   Fri, 25 Jun 2021 12:51:42 -0700
Message-Id: <20210625195148.837230-3-trix@redhat.com>
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
write_init() op if there is nothing for it do.
So add a wrapper and move the op checking.
Default to success.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index ecb4c3c795fa5..c047de8a059b7 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -25,6 +25,15 @@ struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
 };
 
+static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t count)
+{
+	if (mgr->mops->write_init)
+		return  mgr->mops->write_init(mgr, info, buf, count);
+	return 0;
+}
+
 /**
  * fpga_image_info_alloc - Allocate an FPGA image info struct
  * @dev: owning device
@@ -83,9 +92,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 	if (!mgr->mops->initial_header_size)
-		ret = mgr->mops->write_init(mgr, info, NULL, 0);
+		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
 	else
-		ret = mgr->mops->write_init(
+		ret = fpga_mgr_write_init(
 		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
 
 	if (ret) {
@@ -569,7 +578,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	int id, ret;
 
 	if (!mops || !mops->write_complete || !mops->state ||
-	    !mops->write_init || (!mops->write && !mops->write_sg) ||
+	    (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
-- 
2.26.3

