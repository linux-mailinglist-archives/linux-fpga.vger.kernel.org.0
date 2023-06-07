Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6E6725CA0
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Jun 2023 13:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbjFGLDT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Jun 2023 07:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbjFGLDB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Jun 2023 07:03:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 194E926AE;
        Wed,  7 Jun 2023 04:02:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61238AB6;
        Wed,  7 Jun 2023 04:01:40 -0700 (PDT)
Received: from [10.57.75.6] (unknown [10.57.75.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3511D3F663;
        Wed,  7 Jun 2023 04:00:49 -0700 (PDT)
Message-ID: <d275f8af-a422-dd56-dc7d-931ac22e7f5b@arm.com>
Date:   Wed, 7 Jun 2023 12:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 01/32] perf: Allow a PMU to have a parent
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yicong Yang <yangyicong@huawei.com>,
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
 <20230406194938.GB405948@hirez.programming.kicks-ass.net>
 <ZH8vUKt+iCF4M70d@FVFF77S0Q05N.cambridge.arm.com>
 <20230606131859.GC905437@hirez.programming.kicks-ass.net>
 <ZH81DC6xKSH6Tmc7@FVFF77S0Q05N.cambridge.arm.com>
 <20230606134816.GF905437@hirez.programming.kicks-ass.net>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230606134816.GF905437@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-06 14:48, Peter Zijlstra wrote:
> On Tue, Jun 06, 2023 at 02:30:52PM +0100, Mark Rutland wrote:
> 
>>>> Uh, *which* CPU device? Do we have a container device for all CPUs?
>>>
>>> drivers/base/cpu.c:per_cpu(cpu_sys_devices, cpu) for whatever the core
>>> pmu is for that cpu ?
>>
>> ... but the struct pmu covers several CPUs, so I don't have a single 'cpu', no?
>>
>> If I have a system where cpu{0,1,2} are Cortex-A53 and cpu{3,4} are Cortex-A57,
>> I have two struct pmu instances, each associated with several CPUs. When I
>> probe each of those I determine a cpumask for each.
> 
> Bah :/ Clearly I overlooked the disparity there.
> 
>>>>>> My overall favorite is an l2 cache related PMU that is spun up in
>>>>>> arch/arm/kernel/irq.c init_IRQ()
>>>>
>>>> That's an artifact of the L2 cache controller driver getting initialized there;
>>>> ideally we'd have a device for the L2 cache itself (which presumably should
>>>> hang off an aggregate CPU device).
>>>
>>> /sys/devices/system/cpu/cpuN/cache/indexM
>>>
>>> has a struct device somewhere in
>>> drivers/base/cacheinfo.c:ci_index_dev or somesuch.
>>
>> I guess, but I don't think the L2 cache controller (the PL310) is actually tied
>> to that today.
> 
> All it would do is make fancy links in sysfs I think, who cares ;-)
> 
>>>>> Yeah, we're going to have a ton of them as well. Some of them are PCI
>>>>> devices and have a clear parent, others, not so much :/
>>>>
>>>> In a number of places the only thing we have is the PMU driver, and we don't
>>>> have a driver (or device) for the HW block it's a part of. Largely that's
>>>> interconnect PMUs; we could create container devices there.
>>>
>>> Dont they have a PCI device? But yeah, some are going to be a wee bit
>>> challenging.
>>
>> The system might not even have PCI, so it's arguable that they should just hang
>> off an MMIO bus (which is effectively what the platofrm bus is).
> 
> You and your dodgy platforms :-)

For system PMUs we'll pretty much always have a platform device 
corresponding to a DT/ACPI entry used to describe MMIO registers and/or 
interrupts. In many cases the PMU is going to be the only part of the 
underlying device that is meaningful to Linux anyway, so I don't see any 
issue with just hanging the PMU device off its corresponding platform 
device - it still gives the user a way to map a PMU instance back to 
some understandable system topology (i.e. ACPI/DT) to disambiguate, and 
that's the most important thing.

Thanks,
Robin.
