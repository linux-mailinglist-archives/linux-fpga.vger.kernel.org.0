Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619A938B60D
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhETScf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 14:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232273AbhETScf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 14:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621535473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rzVWT+hgucJulWTbb27JAU0YdQhBiQeXz3Y6dtzUOvc=;
        b=XZ3qQjrWc8Msy6XS98kSc2oF+ldsgQTI5YRDcWokREWNhIKxX85Lx+lYJ9pLsZTszrKDpu
        rEODKXULl/o21vgJxB6Ym4TbHK8me0Xb/zdlPOuNdD8DDh60H2Hr/tF2loI9WcWqV+6yrQ
        sAMM39cT3cY/fEq3oC5Kx6MRm19KJ7I=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258--OZnmJzgOnyNaHnVshFyrQ-1; Thu, 20 May 2021 14:31:11 -0400
X-MC-Unique: -OZnmJzgOnyNaHnVshFyrQ-1
Received: by mail-qv1-f69.google.com with SMTP id d9-20020a0ce4490000b02901f0bee07112so7667572qvm.7
        for <linux-fpga@vger.kernel.org>; Thu, 20 May 2021 11:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzVWT+hgucJulWTbb27JAU0YdQhBiQeXz3Y6dtzUOvc=;
        b=F2OrgVS7Ep2FffHZXLVFQBfFm8NgNxm1uoDQNAWi3kfmNy1uqBPToanj34cB1UVbJb
         XY82dNxzvDIfKO2yPtUn30LqHQYXMepfcRywNvdjcBu6li/Xd0j8p0zFgy9adYjZHyT4
         fRsYDCmsAdn6rGbqTMO+Ym5M4w71C4n7/GzOSmrE+33E4u5vCpyjzvWfYTDqxRkWa9FC
         tzDF0flzeGXFtvLBzIDI7HcuCRrRQzFN+ixphrMc8a7TrYAiOYnm4u0rGCdD9Vjhm/QE
         qOTrvrHK31cieiXqFB5mkoPG7CzL/th9Tmsx9qEndR5C06AGRDcgsDj05eIr65Q4pe9R
         FvaQ==
X-Gm-Message-State: AOAM532sSu6AJWRDKLSf0wA0z55inyLOdo4j4bnKYqtcfkStklL8i77H
        cjlLQnU/wrK1XaJg3r4ll4EfLcIENEpwDGCyOeS2J17vJgnooUpAKHPpsbfCHKptVWWIToX8rs0
        2qOTQ2mHVrBoqZUXgXLo85w==
X-Received: by 2002:a05:620a:4101:: with SMTP id j1mr6928632qko.473.1621535471202;
        Thu, 20 May 2021 11:31:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwr9bSXVI+qKOI/88WMXKcwo9b+VphJpj50l+bbQ3An4TsZbQnI8rlBxiGYrWYuBqzTclLdbg==
X-Received: by 2002:a05:620a:4101:: with SMTP id j1mr6928619qko.473.1621535471070;
        Thu, 20 May 2021 11:31:11 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y8sm2544801qtn.61.2021.05.20.11.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:31:10 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 5/5] fpga: use reimage ops in fpga_mgr_load()
Date:   Thu, 20 May 2021 11:31:06 -0700
Message-Id: <20210520183106.2022873-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

If the fpga_image_info flags FPGA_MGR_REIMAGE bit is set
swap out the reconfig ops for the reimage ops and do
the load.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 5247703a3743d..34d251e87ca6c 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -369,6 +369,9 @@ int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
 	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
 
+	if (info->flags & FPGA_MGR_REIMAGE)
+		uops = &mgr->mops->reimage;
+
 	if (!uops->write_complete ||
 	    !uops->write_init ||
 	    (!uops->write && !uops->write_sg) ||
-- 
2.26.3

