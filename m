Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED6938982B
	for <lists+linux-fpga@lfdr.de>; Wed, 19 May 2021 22:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhESUou (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 May 2021 16:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229437AbhESUop (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 19 May 2021 16:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621457005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d7rjCgQxk+5xvpaVNfykovhhV8vEkbL0LJZ6/GWPBlM=;
        b=cJw4wMTse5NVPnr4GgsrjypYE3vGepz3XPvAMsJRXlF/ZQBJWFig7WR9wtfbpsW/Y4bg5J
        k3eJLymhHln9w+/MzbEANzJvMHcktGbOmLK7MGITiT9JZGAqTmZhBTMEED1FLflmQjN3b2
        TbmHArNavAkOTb0kfv6w6h3fyiAlvoI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-1kwW2bUzM0SVqXhMQxtioA-1; Wed, 19 May 2021 16:43:23 -0400
X-MC-Unique: 1kwW2bUzM0SVqXhMQxtioA-1
Received: by mail-qt1-f199.google.com with SMTP id x19-20020ac87a930000b02901f6125bcda0so5243888qtr.19
        for <linux-fpga@vger.kernel.org>; Wed, 19 May 2021 13:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d7rjCgQxk+5xvpaVNfykovhhV8vEkbL0LJZ6/GWPBlM=;
        b=LVsEhCP66PjiQcCuJO5CGNvRE8olYYvs+YWLS7WtI7tXuWWLgbzMBwCFiTxaUqR3zc
         DkO93kWF42KPGzGUqybuFddceGu4cAemF3Qu/Vw77sEbo2HYktcnmPkDkvVtZ7acvIh4
         a5wC3ZKou0mrUvjlyYAvoibbZiT42K+t6ZacJseSmv+cDlXwTgjGl0GaTFIwUwlAS6D/
         RlkzLJbdf+K6fPVhhMORHHNCdvC2eEvV2RGf8O8duw6+5pdeIMfT5zQ2i2pLg5ZsJ+yv
         U7rDuJr3wpAxcT6S9Cd5yS42jxt4VKB5PzxC294ThR/G8pjEvTzqiTe5aH/HOQweoFhn
         v9vw==
X-Gm-Message-State: AOAM533nQLIfuqt/46M5tnXfnbuMf5wQv/nfY+sjjC0EhK2J/EXJ3nVz
        CzjSXAhYXmIwqBmKiYnVK6T/Aeb26xHFAjRo/ZIFDxuWKJrjOrfGkjmRehzIUQ/BeFxEYR91JAt
        e/AhghugHCWYgSrW1TXnm3A==
X-Received: by 2002:a37:38d:: with SMTP id 135mr1520681qkd.136.1621457003296;
        Wed, 19 May 2021 13:43:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdMHznC98oBCZTDwmJO/G1L/uvLiQN7mN+gwV4D1I1ygEupjeNYdhOwwFQ1imXPbyJr2fAFw==
X-Received: by 2002:a37:38d:: with SMTP id 135mr1520665qkd.136.1621457003146;
        Wed, 19 May 2021 13:43:23 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v66sm560563qkd.113.2021.05.19.13.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:43:22 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 2/2] fpga: add cancel() and get_error() to update ops
Date:   Wed, 19 May 2021 13:43:18 -0700
Message-Id: <20210519204318.1976186-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A user may want to cancel an update or get
more information on when an update fails.
Add some device ops to do these.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/fpga/fpga-mgr.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index ab68280f3b4a4..31d6ebc34d87a 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -111,6 +111,8 @@ struct fpga_image_info {
  * @write: write count bytes of configuration data to the FPGA
  * @write_sg: write the scatter list of configuration data to the FPGA
  * @write_complete: set FPGA to operating state after writing is done
+ * @cancel: cancel the update
+ * @get_error: get extended error information
  */
 struct fpga_manager_update_ops {
 	int (*write_init)(struct fpga_manager *mgr,
@@ -120,6 +122,8 @@ struct fpga_manager_update_ops {
 	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
 	int (*write_complete)(struct fpga_manager *mgr,
 			      struct fpga_image_info *info);
+	int (*cancel)(struct fpga_manager *mgr);
+	int (*get_error)(struct fpga_manager *mgr, u64 *err);
 };
 
 /**
-- 
2.26.3

