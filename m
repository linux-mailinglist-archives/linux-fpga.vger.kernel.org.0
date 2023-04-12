Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0A66DF453
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Apr 2023 13:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDLLwi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 Apr 2023 07:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDLLwh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 12 Apr 2023 07:52:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88F7F40F2;
        Wed, 12 Apr 2023 04:52:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6A84D75;
        Wed, 12 Apr 2023 04:53:10 -0700 (PDT)
Received: from [10.57.55.240] (unknown [10.57.55.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 072383F73F;
        Wed, 12 Apr 2023 04:52:18 -0700 (PDT)
Message-ID: <be52a367-1582-4662-f78c-a1e935c6f253@arm.com>
Date:   Wed, 12 Apr 2023 12:52:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 21/32] perf/arm-cmn: Assign parents for event_source
 device
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
Cc:     linuxarm@huawei.com, Dan Williams <dan.j.williams@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
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
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-22-Jonathan.Cameron@huawei.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230404134225.13408-22-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-04 14:42, Jonathan Cameron wrote:
> Currently the PMU device appears directly under /sys/devices/
> Only root busses should appear there, so instead assign the pmu->dev
> parent to be the platform device.

Oh, fab! Just the other week I wrote up a patch doing this after the 
fact with device_move() on the grounds of making the PMU instances 
easier to identify (and with an equivalent cleanup of 
Documentation/admin-guide/perf), which I was close to getting round to 
sending as an RFC. Thus I thoroughly approve :D

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/perf/arm-cmn.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index c9689861be3f..7731eb0e2a4a 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2284,6 +2284,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
>   	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
>   	cmn->pmu = (struct pmu) {
>   		.module = THIS_MODULE,
> +		.parent = &pdev->dev,
>   		.attr_groups = arm_cmn_attr_groups,
>   		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>   		.task_ctx_nr = perf_invalid_context,
