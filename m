Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E076D9DCB
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Apr 2023 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbjDFQpG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Apr 2023 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbjDFQow (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Apr 2023 12:44:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958FE5580;
        Thu,  6 Apr 2023 09:44:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PsnNg5F7Sz6J6fV;
        Fri,  7 Apr 2023 00:42:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 17:44:46 +0100
Date:   Thu, 6 Apr 2023 17:44:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Yicong Yang <yangyicong@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <yangyicong@hisilicon.com>,
        <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        "Khuong Dinh" <khuong@os.amperecomputing.com>,
        Robert Richter <rric@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        "Andy Gross" <agross@kernel.org>,
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
Message-ID: <20230406174445.0000235c@Huawei.com>
In-Reply-To: <20230406124040.GD392176@hirez.programming.kicks-ass.net>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
        <20230404134225.13408-2-Jonathan.Cameron@huawei.com>
        <61f8e489-ae76-38d6-2da0-43cf3c17853d@huawei.com>
        <20230406111607.00007be5@Huawei.com>
        <20230406124040.GD392176@hirez.programming.kicks-ass.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 6 Apr 2023 14:40:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Apr 06, 2023 at 11:16:07AM +0100, Jonathan Cameron wrote:
> 
> > In the long run I agree it would be good.  Short term there are more instances of
> > struct pmu that don't have parents than those that do (even after this series).
> > We need to figure out what to do about those before adding checks on it being
> > set.  
> 
> Right, I don't think you've touched *any* of the x86 PMUs for example,
> and getting everybody that boots an x86 kernel a warning isn't going to
> go over well :-)
> 

It was tempting :) "Warning: Parentless PMU: try a different architecture."

I'd love some inputs on what the x86 PMU devices parents should be?
CPU counters in general tend to just spin out of deep in the architecture code.

My overall favorite is an l2 cache related PMU that is spun up in
arch/arm/kernel/irq.c init_IRQ()

I'm just not going to try and figure out why...

Jonathan

