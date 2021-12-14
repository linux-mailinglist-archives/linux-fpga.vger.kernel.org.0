Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C9C4746CC
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Dec 2021 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhLNPsJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 14 Dec 2021 10:48:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233214AbhLNPsJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 14 Dec 2021 10:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639496888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7VTgCIB0R48iHOUBVfzFpE87tr66KDVNHjpY9sjj8UU=;
        b=N0Y38a/+OOLfls+I2M81Zd6Sc/+NRuKjA6MDYDkXLgfuLT3kiqCZcJxj6m5fdYtN22w1c6
        Kr1Q/Qk9QIlavCt07zPk+CRkcR6hc7AoPCOG5j74LALWOP108Y9HV7ptW4UCuRFpGF3qFf
        RvLZse06aaG9oSHhx154oYqXXW1RdMU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-IMZeHF-KN9-P2l7qbLtfKw-1; Tue, 14 Dec 2021 10:48:07 -0500
X-MC-Unique: IMZeHF-KN9-P2l7qbLtfKw-1
Received: by mail-oo1-f72.google.com with SMTP id t199-20020a4a3ed0000000b002c296d691c4so13010972oot.8
        for <linux-fpga@vger.kernel.org>; Tue, 14 Dec 2021 07:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7VTgCIB0R48iHOUBVfzFpE87tr66KDVNHjpY9sjj8UU=;
        b=bGcSAA26C4XewsVIvONPwZHXiwQmsB/PvZR72wJwfuLPVo5s3aUqSjRMfhCTgNYUPz
         r40aomY9pgX3SCpxyR50NiPBGpkdEhYj/r0MwkO4o1T1OKtUeqDaMyVT2urAOjLKEXDI
         LrrU9vbG/iXOQ7Ypvzg8aNo6/sGozIIzdZYXmyCDO1rJWFhfFK5T7FBuyxqYDVQIJfVM
         WYljY8hDk0TtY3dK6WLES7L6Wrb6d0Oytu/C2vuV0NDcZ74Yh64O9tHFW28UxvplaHK7
         TDilYUbMZdewrdWUYCzW3o+RrYVslXo5BtBarZB/WQj0Rz2nT56biM7feswHqYd1mlGI
         EWRQ==
X-Gm-Message-State: AOAM530+x7GukrYULpJVDx5tRWWQgaMR9AgcyUUmQZ3N6EPlN5wF685/
        cmBq5kZ2FGmSWl4eCoj9IfuAAhhYtvWpxjA9XYTR8tcexLhUU5YNHn7c7oe9Ph45+cbayda550k
        CyND8q3GeVqruKmCnQ4d1KQ==
X-Received: by 2002:a05:6830:2646:: with SMTP id f6mr4981199otu.182.1639496886618;
        Tue, 14 Dec 2021 07:48:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzO/VJ9QrRkFmbcbz26Gaj2JKqDz4NBkMHq74B920BUSvdN1uch4eoYXM1Q0wV0NcqZgvnDhQ==
X-Received: by 2002:a05:6830:2646:: with SMTP id f6mr4981182otu.182.1639496886429;
        Tue, 14 Dec 2021 07:48:06 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g7sm37113oon.27.2021.12.14.07.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 07:48:06 -0800 (PST)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fpga: stratix10-soc: cleanup double word in comment
Date:   Tue, 14 Dec 2021 07:47:49 -0800
Message-Id: <20211214154749.2463147-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

There are two that's in the comment, remove one.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/stratix10-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 357cea58ec98e..862069c95aa3c 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -245,7 +245,7 @@ static int s10_send_buf(struct fpga_manager *mgr, const char *buf, size_t count)
 	int ret;
 	uint i;
 
-	/* get/lock a buffer that that's not being used */
+	/* get/lock a buffer that is not being used */
 	for (i = 0; i < NUM_SVC_BUFS; i++)
 		if (!test_and_set_bit_lock(SVC_BUF_LOCK,
 					   &priv->svc_bufs[i].lock))
-- 
2.26.3

