Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A26E697B1E
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Feb 2023 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjBOLsO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Feb 2023 06:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjBOLsN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 15 Feb 2023 06:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE85838026
        for <linux-fpga@vger.kernel.org>; Wed, 15 Feb 2023 03:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676461631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWla4IxpPAIr1RMijB2VmvTQNQGZkqTx/F5Sx1IMUPQ=;
        b=AovHE+nJ4dA01xPC1U6nlUxnvU0RCuhdZJlurF8yM4mrGJzaQcjvje4lQGpx06+EuBg2uF
        vBUVv5AEIxbFxyS037XSpyjStjbWxHcsxlOKNSHo+8SNteyOOneEBMySk5OrYNZSaBdw6z
        fFXTzjMxmcltPPE0oOhaX8wjc9iCI1Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-65-k02T97ZHOWuhwLlet0gMjw-1; Wed, 15 Feb 2023 06:47:10 -0500
X-MC-Unique: k02T97ZHOWuhwLlet0gMjw-1
Received: by mail-qk1-f198.google.com with SMTP id s7-20020ae9f707000000b007294677a6e8so11317294qkg.17
        for <linux-fpga@vger.kernel.org>; Wed, 15 Feb 2023 03:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWla4IxpPAIr1RMijB2VmvTQNQGZkqTx/F5Sx1IMUPQ=;
        b=ipXe/1MlZ//dlwcJN+A0P20KC1DfQoA8upxz/qFRF18ukf/qAYNGdfnF4bgAffuvkL
         SnqiWnob4iDcdR9ZzhDR6sXWAPgqGj5Gw6bt2GKcvY6ZfYGBF7rT7oo9ZSUbq/tqO23e
         FRrMSNuWQf7ncWThSF/YpF00FzY0kf/HFdnSkMxqevObh5lD8FHIDVVbbY3GfKXoYhxF
         0C5dZ2ZsS6rkiLCo0r0vuyyv6IRIqoXcjBvEyNpkgjnyvUMLyTkz5C1FJSwWexwgcWeI
         VmGZcYKTN+LEGvl4cWdsLe8/puUAXFh1JMhLHkVMfxRDJ9uiJZpSY1tRHU18KRLeb9K8
         0L6w==
X-Gm-Message-State: AO0yUKUaMLzNwqOC08qLBRqpSbDj6A9spmXLo4pQpi55pWZ5krRmF+sO
        OtslYVlYGSmJuHgzF+fusyj6KoTLSX962mtDxEcjrNawjITKlitXKEXXThlC4oQ7pDWY/BC2htR
        hmZH1b/eC+55/Iuo9Vr2Yudx5IA==
X-Received: by 2002:ac8:59d3:0:b0:3b6:9817:18e4 with SMTP id f19-20020ac859d3000000b003b6981718e4mr2848994qtf.49.1676461630136;
        Wed, 15 Feb 2023 03:47:10 -0800 (PST)
X-Google-Smtp-Source: AK7set+ONFsJKriqgRyboXfngZUgoqZTtSrpSfRrC8VyIHG33OdFC+XpiAkZDvoCkfM/mItot1Aa7Q==
X-Received: by 2002:ac8:59d3:0:b0:3b6:9817:18e4 with SMTP id f19-20020ac859d3000000b003b6981718e4mr2848979qtf.49.1676461629870;
        Wed, 15 Feb 2023 03:47:09 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id cc5-20020a05622a410500b003995f6513b9sm5931170qtb.95.2023.02.15.03.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 03:47:09 -0800 (PST)
Message-ID: <93039f92-3462-e2a2-6052-830668419a4d@redhat.com>
Date:   Wed, 15 Feb 2023 12:47:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/4] fpga: add initial KUnit test suite
Content-Language: en-US
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20230203170653.414990-1-marpagan@redhat.com>
 <20230203170653.414990-2-marpagan@redhat.com>
 <3588ad2f-f33f-8979-ba05-29c367716610@intel.com>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <3588ad2f-f33f-8979-ba05-29c367716610@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-02-14 00:37, Russ Weight wrote:
> 
> 
> On 2/3/23 09:06, Marco Pagani wrote:
>> Introduce an initial KUnit suite to test the core components of the
>> FPGA subsystem.
>>
>> The test suite consists of two test cases. The first test case checks
>> the programming of a static image on a fake FPGA with a single hardware
>> bridge. The FPGA is first programmed using a test image stored in a
>> buffer, and then with the same image linked to a single-entry
>> scatter-gather list.
>>
>> The second test case models dynamic partial reconfiguration. The FPGA
>> is first configured with a static image that implements a
>> reconfigurable design containing a sub-region controlled by two soft
>> bridges. Then, the reconfigurable sub-region is reconfigured using
>> a fake partial bitstream image. After the reconfiguration, the test
>> checks that the soft bridges have been correctly activated.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/Kconfig            |   2 +
>>  drivers/fpga/Makefile           |   3 +
>>  drivers/fpga/tests/.kunitconfig |   5 +
>>  drivers/fpga/tests/Kconfig      |  15 ++
>>  drivers/fpga/tests/Makefile     |   6 +
>>  drivers/fpga/tests/fpga-tests.c | 264 ++++++++++++++++++++++++++++++++
>>  6 files changed, 295 insertions(+)
>>  create mode 100644 drivers/fpga/tests/.kunitconfig
>>  create mode 100644 drivers/fpga/tests/Kconfig
>>  create mode 100644 drivers/fpga/tests/Makefile
>>  create mode 100644 drivers/fpga/tests/fpga-tests.c
>>
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 0a00763b9f28..2f689ac4ba3a 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -276,4 +276,6 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
>>  	  FPGA manager driver support for Lattice FPGAs programming over slave
>>  	  SPI sysCONFIG interface.
>>  
>> +source "drivers/fpga/tests/Kconfig"
>> +
>>  endif # FPGA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 72e554b4d2f7..352a2612623e 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -55,3 +55,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>>  
>>  # Drivers for FPGAs which implement DFL
>>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
>> +
>> +# KUnit tests
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
>> diff --git a/drivers/fpga/tests/.kunitconfig b/drivers/fpga/tests/.kunitconfig
>> new file mode 100644
>> index 000000000000..a1c2a2974c39
>> --- /dev/null
>> +++ b/drivers/fpga/tests/.kunitconfig
>> @@ -0,0 +1,5 @@
>> +CONFIG_KUNIT=y
>> +CONFIG_FPGA=y
>> +CONFIG_FPGA_REGION=y
>> +CONFIG_FPGA_BRIDGE=y
>> +CONFIG_FPGA_KUNIT_TESTS=y
>> diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
>> new file mode 100644
>> index 000000000000..5198e605b38d
>> --- /dev/null
>> +++ b/drivers/fpga/tests/Kconfig
>> @@ -0,0 +1,15 @@
>> +config FPGA_KUNIT_TESTS
>> +	tristate "FPGA KUnit tests" if !KUNIT_ALL_TESTS
>> +	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT
>> +	default KUNIT_ALL_TESTS
>> +	help
>> +	  Builds unit tests for the FPGA subsystem. This option
>> +	  is not useful for distributions or general kernels,
>> +	  but only for kernel developers working on the FPGA
>> +	  subsystem and its associated drivers.
>> +
>> +	  For more information on KUnit and unit tests in general,
>> +	  please refer to the KUnit documentation in
>> +	  Documentation/dev-tools/kunit/.
>> +
>> +	  If in doubt, say "N".
>> diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
>> new file mode 100644
>> index 000000000000..74346ae62457
>> --- /dev/null
>> +++ b/drivers/fpga/tests/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-mgr.o
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-region.o
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-bridge.o
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-tests.o
>> diff --git a/drivers/fpga/tests/fpga-tests.c b/drivers/fpga/tests/fpga-tests.c
>> new file mode 100644
>> index 000000000000..33f04079b32f
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fpga-tests.c
>> @@ -0,0 +1,264 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Test suite for the FPGA subsystem
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#include <kunit/test.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/scatterlist.h>
>> +
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/fpga/fpga-region.h>
>> +#include <linux/fpga/fpga-bridge.h>
>> +
>> +#include "fake-fpga-region.h"
>> +#include "fake-fpga-bridge.h"
>> +#include "fake-fpga-mgr.h"
>> +
>> +#define FAKE_BIT_BLOCKS		16
>> +#define FAKE_BIT_SIZE		(FPGA_TEST_BIT_BLOCK * FAKE_BIT_BLOCKS)
>> +
>> +static u8 fake_bit[FAKE_BIT_SIZE];
> 
> I take it "bit" in fake_bit and sgt_bit is short for "bitstream". Initially,
> I found this confusing as I tend to think of a bit as a single bit. It might
> be better to expand that something like "fake_bitstream" or "fake_image".
> 
> - Russ


You're right. Using "bit" in the name can be confusing. I'll change it
to "fake_image" or maybe "fake_image_buf" to be consistent with the naming
convention used in the subsystem. I'll also change "test_img_info"
to "fake_img_info" to improve naming consistency.

Thanks,
Marco

