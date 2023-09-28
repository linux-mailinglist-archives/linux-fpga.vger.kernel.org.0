Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C037B2325
	for <lists+linux-fpga@lfdr.de>; Thu, 28 Sep 2023 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjI1RCh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 28 Sep 2023 13:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1RCh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Sep 2023 13:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8899FAC
        for <linux-fpga@vger.kernel.org>; Thu, 28 Sep 2023 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695920509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJ8io9iHoGzKxYz4jGoEUkvynxWv0l6wFHeyVvwW4Xw=;
        b=cwBoikPg6DKO57iM/2Xc3EDNQkXfz1egyH622EFwMeC8LQgbjRjOGruLTz6e6U6X3Lb4lf
        hToh0l6eghMxvtAHvFcKBRHcMHysAk1j4KhaCsc5Y79IYO9bTja9qbO1VOj294roCCQyql
        fNwnYv+5Fw8aTwZ5AUDJ7FUpKArjnmk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-tVoDMsZuMMOyajz3K26wMw-1; Thu, 28 Sep 2023 13:01:48 -0400
X-MC-Unique: tVoDMsZuMMOyajz3K26wMw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-65cfcccc807so59207146d6.3
        for <linux-fpga@vger.kernel.org>; Thu, 28 Sep 2023 10:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695920507; x=1696525307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ8io9iHoGzKxYz4jGoEUkvynxWv0l6wFHeyVvwW4Xw=;
        b=niXOxM7L9DL9jSrASgONGnaNGZthbp7DZiMQBOYoWnLDq2sEe/m7zRXVHFFcdBdVli
         QZG+5lla2EevvpXU2oAjCvjleOGsIuwRf6RggMIAxmgfnqi9ye59pBl9vB94DkCn9/eh
         7kcz4lHjKoY+D+MW7TUJI3llh7ckZ0GVGNqhHvLYgE011/bxxp6eYVMqQH27P10b5orM
         AEg5eKS70fhrIhq+VNmECbNRyXIUtGqxMypPeONgT6mgZzvc1KxNrRh+QbqCpmIktVRR
         T5+rnP9Wt/znwUzEp5Hh/GjOLf7y9f/sEOpsKsllTIlMlDjbURPPj2DZ6pZljhp61I/m
         F/ow==
X-Gm-Message-State: AOJu0YzCkRavvD/v7pe1vBNIbKb9nz9l4bdAlulT4KnkRuqwyoH11Y+Z
        GCorea8sDubq8JS018H5ULW1aQLpe1+dmvbN1J5Gymo/HOhtkYRCuaqMZmaa/UqMEHisN9omHJA
        IQv+dpkvZ4BnGE6U+Hogp
X-Received: by 2002:a0c:aa5b:0:b0:63c:fa7d:74ee with SMTP id e27-20020a0caa5b000000b0063cfa7d74eemr1743937qvb.50.1695920506993;
        Thu, 28 Sep 2023 10:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsw2oRoFy1oQmAIXh2N4nE+hC646Q49c8ueDG7gmcOgzziSULGO8ra5bgxuXtCOEBTO2n6mQ==
X-Received: by 2002:a0c:aa5b:0:b0:63c:fa7d:74ee with SMTP id e27-20020a0caa5b000000b0063cfa7d74eemr1743912qvb.50.1695920506746;
        Thu, 28 Sep 2023 10:01:46 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id j12-20020a0cf30c000000b0065b0a3ae7c7sm3770646qvl.113.2023.09.28.10.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 10:01:46 -0700 (PDT)
Message-ID: <b12cc469-a885-223b-c16f-2cd346e8d8ba@redhat.com>
Date:   Thu, 28 Sep 2023 19:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] fpga: add helpers for the FPGA KUnit test suites.
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230926163911.66114-1-marpagan@redhat.com>
 <20230926163911.66114-2-marpagan@redhat.com>
 <ZRWjVkMYNosNvlt3@yilunxu-OptiPlex-7050>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZRWjVkMYNosNvlt3@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-09-28 18:01, Xu Yilun wrote:
> On 2023-09-26 at 18:39:08 +0200, Marco Pagani wrote:
>> Add helpers to facilitate the registration of minimal platform drivers
>> to support the parent platform devices used for testing.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/tests/fpga-test-helpers.h | 29 ++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>  create mode 100644 drivers/fpga/tests/fpga-test-helpers.h
>>
>> diff --git a/drivers/fpga/tests/fpga-test-helpers.h b/drivers/fpga/tests/fpga-test-helpers.h
>> new file mode 100644
>> index 000000000000..fcad3249be68
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fpga-test-helpers.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * KUnit test for the FPGA Manager
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#ifndef FPGA_KUNIT_HELPERS_
>> +#define FPGA_KUNIT_HELPERS_
> 
> How about _FPGA_KUNIT_HELPERS_H

That's fine with me. I will change it in v2.

> Others LGTM for this series.
> 
> Thanks,
> Yilun
> 
>> +
>> +#define TEST_PDEV_NAME	"fpga-test-pdev"
>> +
>> +#define TEST_PLATFORM_DRIVER(__drv_name)			\
>> +	__TEST_PLATFORM_DRIVER(__drv_name, TEST_PDEV_NAME)
>> +/*
>> + * Helper macro for defining a minimal platform driver that can
>> + * be registered to support the parent platform devices used for
>> + * testing.
>> + */
>> +#define __TEST_PLATFORM_DRIVER(__drv_name, __dev_name)		\
>> +static struct platform_driver __drv_name = {			\
>> +	.driver = {						\
>> +		.name = __dev_name,				\
>> +	},							\
>> +}
>> +
>> +#endif	/* FPGA_KUNIT_HELPERS_ */
>> -- 
>> 2.41.0
>>
> 

Thanks,
Marco

