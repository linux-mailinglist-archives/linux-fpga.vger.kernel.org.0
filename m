Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB166D72C1
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Apr 2023 05:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjDEDu4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Apr 2023 23:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjDEDuz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Apr 2023 23:50:55 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599E12691;
        Tue,  4 Apr 2023 20:50:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0VfNxCDL_1680666644;
Received: from 30.240.113.3(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VfNxCDL_1680666644)
          by smtp.aliyun-inc.com;
          Wed, 05 Apr 2023 11:50:47 +0800
Message-ID: <9cb06879-d743-e3b2-b8e3-23962b458202@linux.alibaba.com>
Date:   Wed, 5 Apr 2023 11:50:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 18/32] perf/alibaba_uncore: Assign parents for
 event_source device
Content-Language: en-US
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
        Frank Li <Frank.li@nxp.com>, Vineet Gupta <vgupta@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-19-Jonathan.Cameron@huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230404134225.13408-19-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023/4/4 PM9:42, Jonathan Cameron wrote:
> Currently the PMU device appears directly under /sys/devices/
> Only root busses should appear there, so instead assign the pmu->dev
> parent to be the platform device.
> 
> Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/perf/alibaba_uncore_drw_pmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index a7689fecb49d..0d129acf3f84 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -683,6 +683,7 @@ static int ali_drw_pmu_probe(struct platform_device *pdev)
>  
>  	drw_pmu->pmu = (struct pmu) {
>  		.module		= THIS_MODULE,
> +		.parent		= &pdev->dev,
>  		.task_ctx_nr	= perf_invalid_context,
>  		.event_init	= ali_drw_pmu_event_init,
>  		.add		= ali_drw_pmu_add,


Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thank you.

Best Regards,
Shuai
