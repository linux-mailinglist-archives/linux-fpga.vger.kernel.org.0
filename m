Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4686272974E
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jun 2023 12:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjFIKp3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jun 2023 06:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbjFIKnq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Jun 2023 06:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA3B185
        for <linux-fpga@vger.kernel.org>; Fri,  9 Jun 2023 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686307291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8gYnoE1niJ45ESYc4hUF5eNpsn+sHSB1e/bR5qkxCg=;
        b=QOBB0LQlYx8dAykyKldgaATQehP3i2X4pslf51Y2mrNQICxw7gbHEoiTWj31E0jdNzQE3Q
        jpeYU3QXfudNGlcn5WsJJArrgwnUDvgPF9pgfEGe8yL0FVd0sQyofy6tPI/VA7+F4f/sxt
        K3dKMYe5FET9yGo9FzW/5HZm4wGUJFs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-ipQzx-osMqa8nBwVsma1ig-1; Fri, 09 Jun 2023 06:41:30 -0400
X-MC-Unique: ipQzx-osMqa8nBwVsma1ig-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f603fed174so10551295e9.2
        for <linux-fpga@vger.kernel.org>; Fri, 09 Jun 2023 03:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686307289; x=1688899289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8gYnoE1niJ45ESYc4hUF5eNpsn+sHSB1e/bR5qkxCg=;
        b=TfGp3995p151jHZZ5ERt8MaO7Xon9pY5GTcKDltdJwgLpRMuSLiTez+GYN2DjZ9hlM
         ue0Le+fbxIRCncm13ZioiMQa3Lp36txI+fioaYco2dKZa6SylAkeIkZ2yLrMmwJ3QewY
         BIzbCVactfxeQwOqV+ECXMs0H9DcfePPTsk8JiIyHLAQnE3diywjoivQ7dpB6ySsTUdN
         ov+YgoXCOSTPBYfQajEbh5SRwrneopvzRKDQAtOJ3MAilYEsiG5nRhosrx0bAgIPsCP1
         0Z9ucXXHehR84heDerrqiJOT7O77jWYUh4CD2JgJgGIzveexygsr0cRw0UhSUyznhiqh
         QGng==
X-Gm-Message-State: AC+VfDwXV+KO2rU9s1dSxEokXC7UEOkEA3hfmx/TWh580K18GscQc3GG
        PRaCKEqP4u/oJEn+/nz6M1LsCcTl9Vuh8TJbBIPsb5TSTrN3ptXeEJqUckQqHhO+vq4szvzv6pF
        JASlQzVzvhodpetbosdaz
X-Received: by 2002:a7b:cb8f:0:b0:3f7:26f8:4cd0 with SMTP id m15-20020a7bcb8f000000b003f726f84cd0mr816257wmi.16.1686307288900;
        Fri, 09 Jun 2023 03:41:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OOBlxnw76VIueU6pdFyHrQAdMafrflMtvjVYq6MnT1H42dhAaerggO3I10FxuLaISze1TQQ==
X-Received: by 2002:a7b:cb8f:0:b0:3f7:26f8:4cd0 with SMTP id m15-20020a7bcb8f000000b003f726f84cd0mr816251wmi.16.1686307288654;
        Fri, 09 Jun 2023 03:41:28 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-28-201.cust.vodafonedsl.it. [2.34.28.201])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003f7f2a1484csm2318719wmj.5.2023.06.09.03.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 03:41:28 -0700 (PDT)
Message-ID: <4567c582-490b-37d4-d95c-987b4a892fab@redhat.com>
Date:   Fri, 9 Jun 2023 12:41:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v6 3/4] fpga: add an initial KUnit suite for the FPGA
 Region
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230531095405.342080-1-marpagan@redhat.com>
 <20230531095405.342080-4-marpagan@redhat.com>
 <ZIMLWqTT5ikCbY8g@yilunxu-OptiPlex-7050>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZIMLWqTT5ikCbY8g@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-06-09 13:22, Xu Yilun wrote:
> On 2023-05-31 at 11:54:04 +0200, Marco Pagani wrote:
>> The suite tests the programming of an FPGA Region with a Bridge
>> and the function for finding a particular Region.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/tests/fpga-region-test.c | 186 ++++++++++++++++++++++++++
>>  1 file changed, 186 insertions(+)
>>  create mode 100644 drivers/fpga/tests/fpga-region-test.c
>>
>> diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
>> new file mode 100644
>> index 000000000000..81b271088240
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fpga-region-test.c
>> @@ -0,0 +1,186 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * KUnit test for the FPGA Region
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/module.h>
>> +#include <kunit/test.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/fpga/fpga-bridge.h>
>> +#include <linux/fpga/fpga-region.h>
>> +
>> +struct mgr_stats {
>> +	u32 write_count;
>> +};
>> +
>> +struct bridge_stats {
>> +	u32 enable_count;
>> +};
>> +
>> +struct test_ctx {
>> +	struct fpga_manager *mgr;
>> +	struct platform_device *mgr_pdev;
>> +	struct fpga_bridge *bridge;
>> +	struct platform_device *bridge_pdev;
>> +	struct fpga_region *region;
>> +	struct platform_device *region_pdev;
>> +	struct bridge_stats bridge_stats;
>> +	struct mgr_stats mgr_stats;
>> +};
>> +
>> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
>> +{
>> +	struct mgr_stats *stats = mgr->priv;
>> +
>> +	stats->write_count++;
> 
> Could you add some comments to explain why only implement the write op
> to help region test? and why not choose write_complete or other callback?

Sure, I'll do that in the next version.

Thanks,
Marco


> Thanks,
> Yilun
>

[...]

