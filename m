Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30838B604
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 20:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhETSbd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 14:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235089AbhETSbc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 14:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621535410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RCwD0QS5qYMZ3I485ga0mBzEclvb9mUVoGt+KyuaoxM=;
        b=E/xz3NoSmhoNakJl7qxAZIxf8jwulG9xhbsbVCsvkLsalf0lad7zLKTzzIoK7cQcgJI3m8
        U75gZgSolhh7dfQhSkxmd5IKQ4QQa6vCpuWmecIveCAHP23TmRl0E69rTJLehx+VrQdqlA
        eZf9QHt4fM69HUchm1QCZ31ZA+v9Wq4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-V_KzmMqjP6GyleX5Z_o0BA-1; Thu, 20 May 2021 14:30:09 -0400
X-MC-Unique: V_KzmMqjP6GyleX5Z_o0BA-1
Received: by mail-qt1-f200.google.com with SMTP id r1-20020ac85c810000b02901fa9798cdb5so6668467qta.8
        for <linux-fpga@vger.kernel.org>; Thu, 20 May 2021 11:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCwD0QS5qYMZ3I485ga0mBzEclvb9mUVoGt+KyuaoxM=;
        b=isnRb1LI5814xlgl+JuZd0YvakcsMGBUwYA18fOE+N5wAFcy8466KQdGHFKDOMTZOh
         hbgDZ+QM6C4lNGzr1YsWxx10ELR/IFoERcJQyXLNuY1N18GY9VLdNQN9reZezcuzOQ9L
         lmbkuhSJKjTyse6AmuqNIIWDmBW0uHXaGvu4BN7rjw9Wz+aDO2lLWCC2Yz9wEHsF0ySi
         8p5mk8LYTpHHz2bM5Xoq3d2+qMP8nkl23eVDIMacbBNBhOuRoaN7PwWlYW+k2Ra9Y1jz
         dflHXrIflpBAPZy/pdRmqjIMXphQUxL531LNDHIic3llimzKwpOmWm97You+0QACJ1zw
         xS8A==
X-Gm-Message-State: AOAM530fqmH8usT9jgxazmnvqC+WAseb/61YFUsdp6rYyNblDULJaKL6
        3/EpdsASajVrW55X7wkYWGpFcCtjX3k5u0RPgsBuqBv9x7MewWEIxlO+utYkcmTl60JLOi4iC+S
        UENWMKMUYzDr2JlL9rj1CiQ==
X-Received: by 2002:a37:6f42:: with SMTP id k63mr5030589qkc.216.1621535408551;
        Thu, 20 May 2021 11:30:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu+PGA45IxpSIcmoDjGXXutNWvdm/FthshSNGvlLymHTheLReLclqSo5Bl2s3tEOhJStfx9Q==
X-Received: by 2002:a37:6f42:: with SMTP id k63mr5030560qkc.216.1621535408392;
        Thu, 20 May 2021 11:30:08 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p11sm2723200qkj.3.2021.05.20.11.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:30:08 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 2/5] fpga: add FPGA_MGR_REIMAGE flag
Date:   Thu, 20 May 2021 11:30:04 -0700
Message-Id: <20210520183004.2022169-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

If this flag is set the reimage ops will be used otherwise the
reconfig ops will be used to write the image

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/fpga/fpga-mgr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 50a9fea3c47ef..bb11b18527326 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -67,12 +67,15 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ *
+ * %FPGA_MGR_REIMAGE: Reimage the whole card, fpga bs and other device fw
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_REIMAGE                BIT(5)
 
 /**
  * struct fpga_image_info - information specific to a FPGA image
-- 
2.26.3

