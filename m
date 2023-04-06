Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ED06D93CE
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Apr 2023 12:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbjDFKQP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Apr 2023 06:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDFKQO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Apr 2023 06:16:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B94213B;
        Thu,  6 Apr 2023 03:16:12 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pscnh3jgGz6DBZ9;
        Thu,  6 Apr 2023 18:15:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 11:16:08 +0100
Date:   Thu, 6 Apr 2023 11:16:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <yangyicong@hisilicon.com>,
        <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        "Shaokun Zhang" <zhangshaokun@hisilicon.com>,
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
Message-ID: <20230406111607.00007be5@Huawei.com>
In-Reply-To: <61f8e489-ae76-38d6-2da0-43cf3c17853d@huawei.com>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
        <20230404134225.13408-2-Jonathan.Cameron@huawei.com>
        <61f8e489-ae76-38d6-2da0-43cf3c17853d@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Thu, 6 Apr 2023 12:03:27 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> On 2023/4/4 21:41, Jonathan Cameron wrote:
> > Some PMUs have well defined parents such as PCI devices.
> > As the device_initialize() and device_add() are all within
> > pmu_dev_alloc() which is called from perf_pmu_register()
> > there is no opportunity to set the parent from within a driver.
> > 
> > Add a struct device *parent field to struct pmu and use that
> > to set the parent.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > ---
> > Previously posted in CPMU series hence the change log.
> > v3: No change
> > ---
> >  include/linux/perf_event.h | 1 +
> >  kernel/events/core.c       | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index d5628a7b5eaa..b99db1eda72c 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -303,6 +303,7 @@ struct pmu {
> >  
> >  	struct module			*module;
> >  	struct device			*dev;
> > +	struct device			*parent;
> >  	const struct attribute_group	**attr_groups;
> >  	const struct attribute_group	**attr_update;
> >  	const char			*name;
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index fb3e436bcd4a..a84c282221f2 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11367,6 +11367,7 @@ static int pmu_dev_alloc(struct pmu *pmu)
> >  
> >  	dev_set_drvdata(pmu->dev, pmu);
> >  	pmu->dev->bus = &pmu_bus;
> > +	pmu->dev->parent = pmu->parent;  
> 
> If there's no parent assigned, is it ok to add some check here? Then we can find it earlier
> maybe at develop stage.

In the long run I agree it would be good.  Short term there are more instances of
struct pmu that don't have parents than those that do (even after this series).
We need to figure out what to do about those before adding checks on it being
set.

Jonathan

> 
> Thanks.
> 
> >  	pmu->dev->release = pmu_dev_release;
> >  
> >  	ret = dev_set_name(pmu->dev, "%s", pmu->name);
> >   

