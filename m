Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185217400CA
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jun 2023 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjF0QUo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jun 2023 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjF0QUQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Jun 2023 12:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C93590
        for <linux-fpga@vger.kernel.org>; Tue, 27 Jun 2023 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687882773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1hEG4cTYRVu7i3Wn6FIrmN7k3YbK/ETHFfpOADAOms=;
        b=KoL7FtIw4M0C+PgzXLZcvd1geXevxr0Y/mp/85e04o9OtlLrsqWhQbMCZx2nENxCjwntO0
        DWI3r87aSnLLffwEqkJjNLpivvdR1SsWd38HDN4izbozYVuKt5FhWkrm2J0nUBIGpxJ74G
        GW/vYiuMEFfcfqonUE2x4c6tYSN0V3k=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-QWWLfLLZMKCppjYkOHPf4A-1; Tue, 27 Jun 2023 12:19:31 -0400
X-MC-Unique: QWWLfLLZMKCppjYkOHPf4A-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-565842189c4so653880eaf.3
        for <linux-fpga@vger.kernel.org>; Tue, 27 Jun 2023 09:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687882770; x=1690474770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1hEG4cTYRVu7i3Wn6FIrmN7k3YbK/ETHFfpOADAOms=;
        b=UeWTiSYGkzi71RH/GCuUC1wjphnpQ8dfMYIQvnx+aoJBmEBNvC54sRM9z5acmVHYwh
         cpXmNS3zKbz6uwJvK5TD/qXqqaWfNwzcw92bZGIASF36jWnQB7sXhO3lXjYhS0aQHYh7
         ye2xSC1ZvE4TV8jS11fnPhvAKr30SEp0Pk9kFaYSFj9vdtaMVsk0VRmKjP8VRnACSm2f
         2ClcaL6R3iYzUFBsRoY8D3S2j0x4JBBhEM/0sKfGzgBrvE7hrPuHNfJZuxKQmBnpTQdn
         uhUgp7TLA+JWelwYejVVDUzTraLGKNgKVoZo1IVIx77Ip9LKuoB/HuZoVtQqWL39/Glq
         tV+Q==
X-Gm-Message-State: AC+VfDwBxkdoUdKzGjkNna1nQc4dbH8qAoey9p+7XFBLfxKc7QTYIHTB
        PeGZ1QvQNMK39XSd/yhLCf4WS1h14XvG6hbvdEutfZF85VhGGfaSeBW6N49Cbhlhsh/YWZhJ030
        5ErC5cXMLhXHNOLT7C99Q
X-Received: by 2002:a05:6808:30a5:b0:3a1:e4d1:878d with SMTP id bl37-20020a05680830a500b003a1e4d1878dmr5999002oib.9.1687882769139;
        Tue, 27 Jun 2023 09:19:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TE/9DIA1UCoO88m4VqGL/azmypGcrViioc/H2SXDw4w/L4TwXt1NG5LAtJsCReGg8bIv2jA==
X-Received: by 2002:a05:6808:30a5:b0:3a1:e4d1:878d with SMTP id bl37-20020a05680830a500b003a1e4d1878dmr5998985oib.9.1687882768878;
        Tue, 27 Jun 2023 09:19:28 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id l15-20020ad4444f000000b0062439f05b87sm4722507qvt.45.2023.06.27.09.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 09:19:28 -0700 (PDT)
Message-ID: <4c247ee8-58cd-100b-9229-306fb0a0db1d@redhat.com>
Date:   Tue, 27 Jun 2023 18:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 4/4] fpga: add configuration for the FPGA KUnit test
 suites.
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230616154405.220502-1-marpagan@redhat.com>
 <20230616154405.220502-5-marpagan@redhat.com>
 <ZJf5hUkGYCg1YCPx@yilunxu-OptiPlex-7050>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZJf5hUkGYCg1YCPx@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-06-25 10:23, Xu Yilun wrote:
> On 2023-06-16 at 17:44:05 +0200, Marco Pagani wrote:
>> Add configuration for the KUnit test suites for the core components
>> of the FPGA subsystem.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/Kconfig            |  2 ++
>>  drivers/fpga/Makefile           |  3 +++
>>  drivers/fpga/tests/.kunitconfig |  5 +++++
>>  drivers/fpga/tests/Kconfig      | 11 +++++++++++
>>  drivers/fpga/tests/Makefile     |  5 +++++
>>  5 files changed, 26 insertions(+)
>>  create mode 100644 drivers/fpga/tests/.kunitconfig
>>  create mode 100644 drivers/fpga/tests/Kconfig
>>  create mode 100644 drivers/fpga/tests/Makefile
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
>> index 000000000000..e4a64815f16d
>> --- /dev/null
>> +++ b/drivers/fpga/tests/Kconfig
>> @@ -0,0 +1,11 @@
>> +config FPGA_KUNIT_TESTS
>> +	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
>> +	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
> 
> Why KUNIT shouldn't be 'm'
>

The "running tips" section of KUnit documentation suggests that tests should
ideally depend on KUNIT=y in their Kconfigs because some features will not work
when KUNIT=m


>> +	default KUNIT_ALL_TESTS
>> +        help
>> +          This builds unit tests for the FPGA subsystem
>> +
>> +          For more information on KUnit and unit tests in general,
>> +          please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
>> +
>> +          If unsure, say N.
>> diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
>> new file mode 100644
>> index 000000000000..faa5fa230ab0
>> --- /dev/null
>> +++ b/drivers/fpga/tests/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-mgr-test.o
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-bridge-test.o
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-region-test.o
> 
> Could be integrated in one line?

Yes.

> 
> Thanks,
> Yilun
> 
>> -- 
>> 2.40.1
>>
> 

