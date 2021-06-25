Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315E53B4967
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhFYTyn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 15:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229999AbhFYTyk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 15:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624650739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjAdCEfiqEm9c0Ynsebg4BWNbSDpcr72TwU3P0oRZpc=;
        b=VSF5jgK+HMRUdpnVfJO8GcCW2SspgeM/uGFcNANNoFl/zGsjkHZanx4ZfGxxgcu2If9p3E
        olgb3eUcOUl2eI9SHZTr05sfDxR7hQVFY9Z0YmoYIeBlx4nRmIrs/SUq1Rjc8A9bR373nO
        Pg5XeMdqFj7n4B0Z/ajacxBbSJuN/5M=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-PnmrCepzOiyCvQBgdCDGHQ-1; Fri, 25 Jun 2021 15:52:18 -0400
X-MC-Unique: PnmrCepzOiyCvQBgdCDGHQ-1
Received: by mail-ot1-f71.google.com with SMTP id y6-20020a9d51860000b029046100bd0f34so3876700otg.22
        for <linux-fpga@vger.kernel.org>; Fri, 25 Jun 2021 12:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjAdCEfiqEm9c0Ynsebg4BWNbSDpcr72TwU3P0oRZpc=;
        b=g+WhGDC56t2uqI17u9Y72x9ki08wTlaGe7tU6OKjKqi0Z86ZRk8T6gozN2vnN75a6Y
         4yCdehQLv2sTgDiFX7whjLUc2eMczyTqPk7yIIqvpGQIeTF0avcnJc1gJSygv/7PSdA3
         Zsn3ik4XqI6BtPLgNniM2CA8RRul7+vtSIk/cKZj8MRS5J/aIYyIfvVhU1AraQe1/8Li
         gFkhzGxfN9B2kJaCGOehLshMRIgNpbgMJ8dVZnFuR55X6B4QfrX6WAexhi3qFGLp03lk
         Tj0Hy7Tg18/ToFrh0H/SjcFszImR4xb5GFLQVH79d5d8+gXwIc1oj45WAKErW2TBCOqH
         9vGg==
X-Gm-Message-State: AOAM533KeMnCpPrfo7zkWqJ5FLTWVg4yGjKSXYzIc53bGox1k2It9W5f
        Qz5A11pmB52FJ5gB7WHtV906t2mimtD037hSbID78sgljjRQZAk0jol4n/0m3TLYQynJXLPeBID
        P7svSYHjdzvktj4jgL7aRag==
X-Received: by 2002:aca:e107:: with SMTP id y7mr12990072oig.11.1624650737409;
        Fri, 25 Jun 2021 12:52:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF1c4CKnAxDSoTM1uv3ouUh/l8z5JnAQLTGazp+4FQ/B0la7C6C13aQqkvGpjE5+63AdBssw==
X-Received: by 2002:aca:e107:: with SMTP id y7mr12990063oig.11.1624650737263;
        Fri, 25 Jun 2021 12:52:17 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm1535446ood.20.2021.06.25.12.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:52:17 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 6/7] fpga-mgr: wrap the fpga_remove() op
Date:   Fri, 25 Jun 2021 12:51:47 -0700
Message-Id: <20210625195148.837230-8-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195148.837230-1-trix@redhat.com>
References: <20210625195148.837230-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager is not required to provide a fpga_remove() op.
Add a wrapper consistent with the other op wrappers.
Move op check to wrapper.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index b3380ad341d22..077c0f9edbe4c 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -25,6 +25,12 @@ struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
 };
 
+static inline void fpga_mgr_fpga_remove(struct fpga_manager *mgr)
+{
+	if (mgr->mops->fpga_remove)
+		mgr->mops->fpga_remove(mgr);
+}
+
 static inline enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
 {
 	if (mgr->mops->state)
@@ -745,8 +751,7 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 	 * If the low level driver provides a method for putting fpga into
 	 * a desired state upon unregister, do it.
 	 */
-	if (mgr->mops->fpga_remove)
-		mgr->mops->fpga_remove(mgr);
+	fpga_mgr_fpga_remove(mgr);
 
 	device_unregister(&mgr->dev);
 }
-- 
2.26.3

