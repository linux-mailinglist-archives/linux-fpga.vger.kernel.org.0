Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA70E3B3874
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Jun 2021 23:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhFXVUO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Jun 2021 17:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232670AbhFXVUN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Jun 2021 17:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624569473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06yao2CDsis15QoJOXCwwfY4/53M6JaTIu7lUfBh14M=;
        b=KCHwwo+P2gSAkS8St5aVdMhZbMI2t7N0SL8vtxV8SGZqztEjWbA889jerCJFkZgoxuX3Ts
        Rza2jLsP4AK8mPohF+jyZeR42P6gwujx7wWKhMTblaaxNVyyEEOBD69GN2xmaT9MTvDWit
        iMU15utuLqq9OS+JYUPU5LxVEPM254Q=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-F7be4wlaMqKnnzPPauAe0Q-1; Thu, 24 Jun 2021 17:17:52 -0400
X-MC-Unique: F7be4wlaMqKnnzPPauAe0Q-1
Received: by mail-oo1-f70.google.com with SMTP id q3-20020a4aa3030000b029024b18087470so4514816ool.5
        for <linux-fpga@vger.kernel.org>; Thu, 24 Jun 2021 14:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06yao2CDsis15QoJOXCwwfY4/53M6JaTIu7lUfBh14M=;
        b=oQ+MDTZCgqBMCls3a4/as6jmURujxkMCgbB9U8wD18ClEPOp/667Pl4+dKHkaxmA4D
         sOoLZjbhrvIBz4OiOwHWd7aNFa3b9lEEQKcac8AS0O68NBg6xJvwqMf4yxctR2g4nCiq
         kExz0izqX6GoT71WQMhtzwf6EaHRZSanrKmpbJkV1+7H4KGsxcf2dvBHjvlfmOhKeCcO
         MRKzYl65XuWjXE+x7zA6pUfn8Tz4nKeOMXJ2eFq2+fIis18Fp+rhhoZFWIc+edArit31
         vsjZefgg3sPe+3IxeMmvKVQ7SuRTJtoMXVmqAIcIfU8VoZRGdxTurhXeMu0I1Oz3QGq+
         YC6A==
X-Gm-Message-State: AOAM530qWYf0vy2OPj2TQvN7wh73xU+i2YvIV3fVo48XqVXPftr4HQfJ
        En0sOhSe/swc24e5Jrp9q4kchg8gR7lzjZVVnFWtyvq6V0BPb2KzKfC1pgrPx3ZK/bfN2VzPa7Q
        1t0WK7NS7wzxxBN0KL41eXg==
X-Received: by 2002:a4a:41d2:: with SMTP id x201mr2732000ooa.35.1624569471624;
        Thu, 24 Jun 2021 14:17:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwipQ+FG1zdbSHi5cUqqClnF72jO5dbxM0s0OMGyT/NJe/wW8gpvlxwYtX9N8bXPmn34b+0Kg==
X-Received: by 2002:a4a:41d2:: with SMTP id x201mr2731989ooa.35.1624569471466;
        Thu, 24 Jun 2021 14:17:51 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 94sm915513otj.33.2021.06.24.14.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:17:49 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 2/5] fpga: add FPGA_MGR_REIMAGE flag
Date:   Thu, 24 Jun 2021 14:17:24 -0700
Message-Id: <20210624211727.501019-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210624211727.501019-1-trix@redhat.com>
References: <20210624211727.501019-1-trix@redhat.com>
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
index 53f9402d6aa17..0791e22b07f88 100644
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
  * struct fpga_image_info - information specific to an FPGA image
-- 
2.26.3

