Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF7A6A6DCA
	for <lists+linux-fpga@lfdr.de>; Wed,  1 Mar 2023 15:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCAOEI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 1 Mar 2023 09:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCAOEH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 1 Mar 2023 09:04:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D122782
        for <linux-fpga@vger.kernel.org>; Wed,  1 Mar 2023 06:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677679399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OPcCye6IbsOS6TPPQL+ZOfj0BZvbnC0wnJLL+X1w++0=;
        b=V1kzeekmLNO1fbwdyRD7h8qMNQuTLMyVF1FppwdAG4MzCkUo0MIFgnkTpTgIHpcLiIOzMi
        DTYM9c+iPjmIU3/0xAPuZ89NQWpih1Nu+Z3Svq9msyJCbQ9BwTuQ1N30xBSdajl7LhhBNx
        WlMZ1+8izIENdWgDqwrSZOQJNfG0Uq8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-537-Hezc26I8NTuW2DXRPvcwcw-1; Wed, 01 Mar 2023 09:03:17 -0500
X-MC-Unique: Hezc26I8NTuW2DXRPvcwcw-1
Received: by mail-wr1-f71.google.com with SMTP id d14-20020adfa34e000000b002bfc062eaa8so2606321wrb.20
        for <linux-fpga@vger.kernel.org>; Wed, 01 Mar 2023 06:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677679396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPcCye6IbsOS6TPPQL+ZOfj0BZvbnC0wnJLL+X1w++0=;
        b=ag3dLsqhj9Yd1qM0lCenWt7BFQ9b4bq3ORvnPUmiD8S73RkoUOjWjE60/6lbnP42bq
         k0Xx28LdO9X53HAhyFxAeeRshsINRtLoSpCua2U/MGMwzBm4d5yUf4RkpW28u8Uer253
         msDcaTe1IXlQzs5RmKXN1rCOFF8kv47VI2XcMGMO+IgjFypehMKtG7RetarIG3TlgiBB
         9SWR/N3tZjW/HB0h4iqs+lcaU0azFaImhQA2m+VwftGCSiH286SQpEZFr1KvpthyulLs
         sd9LbodNNQ5ao0T7V6m+DYR21xi7tQLw19DwZgsrYUbzJYfi5HqQxu/shnRH+2JdfQ1P
         3zqA==
X-Gm-Message-State: AO0yUKWkFM42dGLcCROct/j/n1RdTF1hKk9VprkR05Rgg8GSalSKY790
        5hs9MMeiD+MchiH2P+Wip5UJOJnNlSnTeSkFpJSrTFi9TM9l2gjsyZhCARaejy9irI9sz3ww6OP
        wbDN+Xd+MjqLNoGGGnUQ9
X-Received: by 2002:a05:6000:12cb:b0:2c7:dec:77a8 with SMTP id l11-20020a05600012cb00b002c70dec77a8mr4396805wrx.57.1677679396407;
        Wed, 01 Mar 2023 06:03:16 -0800 (PST)
X-Google-Smtp-Source: AK7set+f3vfjFdrHKZdPcRzXPnzvXa0v8gj4mrbOqXoIeqQjI/jVUlJ/YhlJpZQiwQPucIj038EtZQ==
X-Received: by 2002:a05:6000:12cb:b0:2c7:dec:77a8 with SMTP id l11-20020a05600012cb00b002c70dec77a8mr4396778wrx.57.1677679396043;
        Wed, 01 Mar 2023 06:03:16 -0800 (PST)
Received: from klayman.station (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id d2-20020adfe842000000b002c552c6c8c2sm12841612wrn.87.2023.03.01.06.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:03:15 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Tull <atull@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: bridge: fix kernel-doc parameter description
Date:   Wed,  1 Mar 2023 15:03:08 +0100
Message-Id: <20230301140309.512578-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fix the kernel-doc description for the "struct fpga_image_info *info"
parameter of the fpga_bridge_get() function.

Fixes: 060ac5c8fa7b ("fpga: bridge: kernel-doc fixes")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 5cd40acab5bf..ff4470067ed5 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -115,7 +115,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 /**
  * fpga_bridge_get - get an exclusive reference to an fpga bridge
  * @dev:	parent device that fpga bridge was registered with
- * @info:	fpga manager info
+ * @info:	fpga image specific information
  *
  * Given a device, get an exclusive reference to an fpga bridge.
  *
-- 
2.39.2

