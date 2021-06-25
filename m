Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4FF3B4965
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 21:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFYTyj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 15:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229956AbhFYTyg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 15:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624650734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nd5/Ncm9trzPQHKxxw2QIB0gwtpNADHT5q5Ylf5cTos=;
        b=dDabgF/oW6+BXvN/H/opZQ+o//hs9cwO9glyDFlwTWpgIPTOCHKoxW3mHXisNk/t0v/2/8
        hrAe2bwCRldNqcUhtisi1GWSWHrjO2kDTR6yPgiHs+GBHWBla9MfabAt8JHA0Ky/evuX5o
        j9DK7+MB+AQBgZ6V+6QfPmC0EN5C5hA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-eW7b5Mr6PLmZjl5VtPJksA-1; Fri, 25 Jun 2021 15:52:13 -0400
X-MC-Unique: eW7b5Mr6PLmZjl5VtPJksA-1
Received: by mail-oi1-f199.google.com with SMTP id r3-20020aca44030000b02902241b7398a8so6511112oia.19
        for <linux-fpga@vger.kernel.org>; Fri, 25 Jun 2021 12:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nd5/Ncm9trzPQHKxxw2QIB0gwtpNADHT5q5Ylf5cTos=;
        b=AZYsSYh3g2C8Ae+TsBobq1GE13bJN4A8U9k8YbqkpPAvQ8d/0CLij7s744Moxl/RUk
         +UJb8Wo3Hkd1VnEzyBopzsIbNy8bMYZYG75fjqiqu2X2SWT0CLrHG6JXXTthF63XT3Iv
         xLPrBgJ+cSjE4PwvC8a/LZghLiXc9aruNSwTPSDQBimM5WIjh33o9W1NRJJz4QCdgk2d
         9Eo4M9DvjRjdGmDnxfMdjGzRtTOkgGYwiFyN0Iw5MwAE4WKmM9onmAijFM3ebTVIYLf3
         haVzT3tj+Glyty6o7e2ve2EQIyUOf8qDh09cpTxMfHQCnugeak38QVc2qF4IfIgFC7nh
         q4/A==
X-Gm-Message-State: AOAM530AxHMZw5h4yu1Srk+CuJYXM3Ydp6bw/sDN2x2qAz7CRz5WsbCC
        usYziz5AXm5YxtSlXBiKKikBrO/0WKYb+zF/0efJEduWnNhXJMeoEZi8DCnCAExkTQ7Xe3ptPQm
        7kSPpiXD42QhKqAcTqIWG/Q==
X-Received: by 2002:a9d:6219:: with SMTP id g25mr11096324otj.262.1624650732932;
        Fri, 25 Jun 2021 12:52:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOFoWkEHJLZJiCZogum6sza4B5EXPuEPCfHnSXmakawUVjrxJB8y25xvgEdsfFXS38d1e+fQ==
X-Received: by 2002:a9d:6219:: with SMTP id g25mr11096313otj.262.1624650732804;
        Fri, 25 Jun 2021 12:52:12 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm1535446ood.20.2021.06.25.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:52:12 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 4/7] fpga-mgr: wrap the status() op
Date:   Fri, 25 Jun 2021 12:51:45 -0700
Message-Id: <20210625195148.837230-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195148.837230-1-trix@redhat.com>
References: <20210625195148.837230-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager is not required to provide a status() op.
Add a wrapper consistent with the other op wrappers.
Move the op check to the wrapper.
Default to 0, no errors to report.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 8d5536d748081..43518b6eed21e 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -25,6 +25,13 @@ struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
 };
 
+static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
+{
+	if (mgr->mops->status)
+		return mgr->mops->status(mgr);
+	return 0;
+}
+
 static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
 {
 	if (mgr->mops->write)
@@ -434,10 +441,7 @@ static ssize_t status_show(struct device *dev,
 	u64 status;
 	int len = 0;
 
-	if (!mgr->mops->status)
-		return -ENOENT;
-
-	status = mgr->mops->status(mgr);
+	status = fpga_mgr_status(mgr);
 
 	if (status & FPGA_MGR_STATUS_OPERATION_ERR)
 		len += sprintf(buf + len, "reconfig operation error\n");
-- 
2.26.3

