Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4F3B3879
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Jun 2021 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhFXVU1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Jun 2021 17:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232732AbhFXVU0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Jun 2021 17:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624569485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEL5AZ4mSr0YqB6XpyjJsxT+Qv98DMEzNJZysot2Lnw=;
        b=ZwiE+HjbygU4UT7UJqDB+kuXKYSD0docsyNbPgzNRfuNoEbFAfrMJs1t8qLaMhxfAdpcEk
        7ZdVQR6JUrixw/0CuD0qJG7RdAFClzkKc+VrU75Z5Bv9RluteZf7mTR9FN4AU3Lo854Q4E
        ncN1GTGXg1Sv1dcM9TGcFBZtCvtDRZE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-8QNwk_Y_Mjyi-l_2TlV2DQ-1; Thu, 24 Jun 2021 17:18:02 -0400
X-MC-Unique: 8QNwk_Y_Mjyi-l_2TlV2DQ-1
Received: by mail-oi1-f197.google.com with SMTP id v142-20020acaac940000b02901f80189ca30so4543546oie.22
        for <linux-fpga@vger.kernel.org>; Thu, 24 Jun 2021 14:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEL5AZ4mSr0YqB6XpyjJsxT+Qv98DMEzNJZysot2Lnw=;
        b=WMbL0BWJ94Vzk+yarMntFHTMQfvij80+S4mrmSIzXGPGIc3iks4fcVywv1xY4LdwWM
         XqM6xvhceKrS5v9nwpL781J7PRYAsTwFSImyLZ5Ef6Oqqd6JrbvCA/hGkCb35Jvz3UxP
         HVddh7NHUqvvLjLRTDbDpD9yTgwRwaVattg5Jbd/J8CfujcThu6ry/Povh/kmNfyu9il
         fRAcyOfitfyJVxC6fou7zGpCQlmJPqDygKYf7eS5VCqPOOSwwuZgYgodd5G/F2zil1yK
         nbCiJ9zHzn6v6Uk4bsVtwXceniIhLvb6Lk7SVBM0KaHhlDyffJYltwKKfgijDFbFAF2g
         KOoA==
X-Gm-Message-State: AOAM531EH/nCeZM28DQRow2rPgpsFX7HAFmUBx7Gdfuy9afJRVIQMtw6
        cwbYTYwdRmPYHpP3CvRdP/Zx63qg0mJbBuf8bevy3SrAfLOpTdnrhMmom2WJszu4hBa8rutkymd
        icV0xDdoAkoJccm7LBWWjGA==
X-Received: by 2002:a05:6830:270b:: with SMTP id j11mr6370723otu.161.1624569481796;
        Thu, 24 Jun 2021 14:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOtcE8iHvqrMnsAhoUJeiWnBz2O5EA2IJu/b1p2L7kvKl5sId+fviItFlU87dzuMw8Y+u/bg==
X-Received: by 2002:a05:6830:270b:: with SMTP id j11mr6370708otu.161.1624569481664;
        Thu, 24 Jun 2021 14:18:01 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 94sm915513otj.33.2021.06.24.14.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:18:00 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 5/5] fpga: fpga-mgr: simplify mops check in wrappers
Date:   Thu, 24 Jun 2021 14:17:27 -0700
Message-Id: <20210624211727.501019-7-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210624211727.501019-1-trix@redhat.com>
References: <20210624211727.501019-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The mops value is checked in fpga_mgr_create,
do not check it twice.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 2abb7043858dc..21b4fd34b1dbf 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -28,14 +28,14 @@ struct fpga_mgr_devres {
 /* mops wrappers */
 static inline enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
 {
-	if (mgr->mops && mgr->mops->state)
+	if (mgr->mops->state)
 		return  mgr->mops->state(mgr);
 	return FPGA_MGR_STATE_UNKNOWN;
 }
 
 static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
 {
-	if (mgr->mops && mgr->mops->status)
+	if (mgr->mops->status)
 		return mgr->mops->status(mgr);
 	return 0;
 }
@@ -93,7 +93,7 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
 
 static inline void fpga_mgr_fpga_remove(struct fpga_manager *mgr)
 {
-	if (mgr->mops && mgr->mops->fpga_remove)
+	if (mgr->mops->fpga_remove)
 		mgr->mops->fpga_remove(mgr);
 }
 
-- 
2.26.3

