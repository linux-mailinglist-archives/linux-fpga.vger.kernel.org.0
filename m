Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D8F40B6C5
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Sep 2021 20:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhINSZR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 14 Sep 2021 14:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231642AbhINSZP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 14 Sep 2021 14:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631643837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tQ+w8rAWfrqtUReBf3svsx7cUQH+Y32dBT7DCvHOI6A=;
        b=U05FlwaCGrTcVb9g5EFZUUa/eGZaq2mGgtAxwMtn4/9AXnagoRZUaInDTSm7TsCTSYy4gS
        /8ZBmVxa0gYqCZgsW5djKSdRx0khwshy2gNYBoagOmTerhr61dEPP+bKLqDA5r5xqcir+8
        +ntDNa7YENpVIxo4+9kZiKUxjFvnv7I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-NRKfVAOONvaXJ0_o8p0UCw-1; Tue, 14 Sep 2021 14:23:56 -0400
X-MC-Unique: NRKfVAOONvaXJ0_o8p0UCw-1
Received: by mail-qk1-f198.google.com with SMTP id g73-20020a379d4c000000b003d3ed03ca28so440915qke.23
        for <linux-fpga@vger.kernel.org>; Tue, 14 Sep 2021 11:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tQ+w8rAWfrqtUReBf3svsx7cUQH+Y32dBT7DCvHOI6A=;
        b=OUSUM3AKBEDYDhjTCfNYYgHpmgHTkVkomcL2bXaAZreEN/pnKdlr53ZLMafn27UE69
         k8P4GsZJZuHnbYK+kWjTxJXYHaRCnqsYZc9YO5YQ55qxLKA2bYwlFFx97LHlwxYX/M1t
         fCOmBqL5MUcfZ4lH50ceac1+RUVFEd+Soj/2izVBE87brpgAPDFAPjkI+PktJSHLIycd
         gjrmVxb8uYL9CmSJ5gY4NEumxkZrxb8b64+syhyELA5SIOqBCjY8opjFdxsEg5ZjQHCY
         ZTOH20buJxfCFn4jWZYt4LhCzwUMrpN02OpzL7O771BEBTV1+AE0px9zIrw0Kzt93Ckr
         1s9g==
X-Gm-Message-State: AOAM531E8bhpglq3b0dNimtBzLVwlJzYqCCc5L8NHB0diNa75lcLUKWq
        42lVF2aGR4AUp4JXv6Fq8eJTjwxeuiMpMrLxUWrm0QNkn4wRkXyZ6nmHWWN93zXkRShGGC+UAlg
        jbkGHUm7ywIdCx78B8Ph4Qw==
X-Received: by 2002:a37:6354:: with SMTP id x81mr6469691qkb.330.1631643836319;
        Tue, 14 Sep 2021 11:23:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkRJTWnJTvpzK6RAFdSwPBJywRxNugcI5zXXYwbUK0aD5GUgQLaVKIxwDkQgC2wMrhXMD0bw==
X-Received: by 2002:a37:6354:: with SMTP id x81mr6469680qkb.330.1631643836128;
        Tue, 14 Sep 2021 11:23:56 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r23sm6546468qtp.60.2021.09.14.11.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:23:55 -0700 (PDT)
From:   trix@redhat.com
To:     mfd@kernel.org, hao.wu@intel.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] MAINTAINERS: Add Tom Rix as fpga maintainer
Date:   Tue, 14 Sep 2021 11:23:33 -0700
Message-Id: <20210914182333.3903389-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

I am the maintainer of the fpga/ subsystem for both the kernel and
userspace for Red Hat.  I have been an active reviewer and contributor
on for public fpga/ subsystem for the last year.  I would like to
help out more.

Since I am paid to do this work, change the status to Supported.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04fa4edf100b83..0443d7ab826659 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7353,9 +7353,9 @@ F:	include/uapi/linux/fpga-dfl.h
 
 FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
-R:	Tom Rix <trix@redhat.com>
+M:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
-S:	Maintained
+S:	Supported
 W:	http://www.rocketboards.org
 Q:	http://patchwork.kernel.org/project/linux-fpga/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
-- 
2.26.3

