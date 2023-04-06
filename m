Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCAE6D8E37
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Apr 2023 06:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjDFEEU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Apr 2023 00:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjDFEET (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Apr 2023 00:04:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692EE902D;
        Wed,  5 Apr 2023 21:04:17 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PsSX227vHzrZDS;
        Thu,  6 Apr 2023 12:02:58 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Apr 2023 12:03:28 +0800
CC:     <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Robert Richter <rric@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Frank Li <Frank.li@nxp.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
Subject: Re: [PATCH 01/32] perf: Allow a PMU to have a parent
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-2-Jonathan.Cameron@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <61f8e489-ae76-38d6-2da0-43cf3c17853d@huawei.com>
Date:   Thu, 6 Apr 2023 12:03:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230404134225.13408-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023/4/4 21:41, Jonathan Cameron wrote:
> Some PMUs have well defined parents such as PCI devices.
> As the device_initialize() and device_add() are all within
> pmu_dev_alloc() which is called from perf_pmu_register()
> there is no opportunity to set the parent from within a driver.
> 
> Add a struct device *parent field to struct pmu and use that
> to set the parent.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ---
> Previously posted in CPMU series hence the change log.
> v3: No change
> ---
>  include/linux/perf_event.h | 1 +
>  kernel/events/core.c       | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d5628a7b5eaa..b99db1eda72c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -303,6 +303,7 @@ struct pmu {
>  
>  	struct module			*module;
>  	struct device			*dev;
> +	struct device			*parent;
>  	const struct attribute_group	**attr_groups;
>  	const struct attribute_group	**attr_update;
>  	const char			*name;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fb3e436bcd4a..a84c282221f2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11367,6 +11367,7 @@ static int pmu_dev_alloc(struct pmu *pmu)
>  
>  	dev_set_drvdata(pmu->dev, pmu);
>  	pmu->dev->bus = &pmu_bus;
> +	pmu->dev->parent = pmu->parent;

If there's no parent assigned, is it ok to add some check here? Then we can find it earlier
maybe at develop stage.

Thanks.

>  	pmu->dev->release = pmu_dev_release;
>  
>  	ret = dev_set_name(pmu->dev, "%s", pmu->name);
> 
