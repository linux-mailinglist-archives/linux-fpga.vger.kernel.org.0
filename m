Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728296DF5D0
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Apr 2023 14:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjDLMlm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 Apr 2023 08:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLMll (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 12 Apr 2023 08:41:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E929646B1;
        Wed, 12 Apr 2023 05:41:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FB8FD75;
        Wed, 12 Apr 2023 05:42:19 -0700 (PDT)
Received: from [10.57.55.240] (unknown [10.57.55.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 422CA3F73F;
        Wed, 12 Apr 2023 05:41:29 -0700 (PDT)
Message-ID: <71167f33-1e54-53ed-0101-c7293149d89b@arm.com>
Date:   Wed, 12 Apr 2023 13:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/32] perf: Allow a PMU to have a parent
Content-Language: en-GB
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        yangyicong@hisilicon.com, linuxarm@huawei.com,
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
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-2-Jonathan.Cameron@huawei.com>
 <61f8e489-ae76-38d6-2da0-43cf3c17853d@huawei.com>
 <20230406111607.00007be5@Huawei.com>
 <20230406124040.GD392176@hirez.programming.kicks-ass.net>
 <20230406174445.0000235c@Huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230406174445.0000235c@Huawei.com>
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

On 2023-04-06 17:44, Jonathan Cameron wrote:
> On Thu, 6 Apr 2023 14:40:40 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Thu, Apr 06, 2023 at 11:16:07AM +0100, Jonathan Cameron wrote:
>>
>>> In the long run I agree it would be good.  Short term there are more instances of
>>> struct pmu that don't have parents than those that do (even after this series).
>>> We need to figure out what to do about those before adding checks on it being
>>> set.
>>
>> Right, I don't think you've touched *any* of the x86 PMUs for example,
>> and getting everybody that boots an x86 kernel a warning isn't going to
>> go over well :-)
>>
> 
> It was tempting :) "Warning: Parentless PMU: try a different architecture."
> 
> I'd love some inputs on what the x86 PMU devices parents should be?
> CPU counters in general tend to just spin out of deep in the architecture code.
> 
> My overall favorite is an l2 cache related PMU that is spun up in
> arch/arm/kernel/irq.c init_IRQ()
> 
> I'm just not going to try and figure out why...

I think that's simply because the PMU support was hung off the existing 
PL310 configuration code, which still supports non-DT boardfiles. The 
PMU shouldn't strictly need to be registered that early, it would just 
be a bunch more work to ensure that a platform device is available for 
it to bind to as a regular driver model driver, which wasn't justifiable 
at the time.

Thanks,
Robin.
