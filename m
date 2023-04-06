Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487FC6D9726
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Apr 2023 14:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjDFMld (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Apr 2023 08:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDFMlc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Apr 2023 08:41:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55D7A8D;
        Thu,  6 Apr 2023 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HyuEKh43IWrWdzVowQkaLP3FmrQYVn2EQx+OBqF6IKE=; b=OTfNiEwwYqj1eXzVk8GGYFt99j
        lb9FiQit+vNRBvJWsfnsbh7pdcuhULQzT0jUHTM1oo/wvO7JO86mXApYNvM8CRQvMbH2ZL3TFSwMM
        LymyCc/40mXnWO1XtiUalA2d9ccxHJeagVSyPV1TvlMErhNnICGgW7WkazHQ0pxK241uOQDEv3pSV
        sTEOGyBpXMZmPpMn02sdu5EFYV87D1n3ureXfzou3cucKB1kU4MowP4vU8mRFGE5QltsqWthavZXl
        hw5e23dB3M9XJLhmGx+vAiE+/h6idPF1CzXo+7N1tCWqhVTjfiyq+MaElg5ObfWlwnIt/nMC4sHjz
        3sTG6jhA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkOuy-00HQ2r-RR; Thu, 06 Apr 2023 12:40:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D26E300194;
        Thu,  6 Apr 2023 14:40:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C03D212E36AA; Thu,  6 Apr 2023 14:40:40 +0200 (CEST)
Date:   Thu, 6 Apr 2023 14:40:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH 01/32] perf: Allow a PMU to have a parent
Message-ID: <20230406124040.GD392176@hirez.programming.kicks-ass.net>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-2-Jonathan.Cameron@huawei.com>
 <61f8e489-ae76-38d6-2da0-43cf3c17853d@huawei.com>
 <20230406111607.00007be5@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406111607.00007be5@Huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 06, 2023 at 11:16:07AM +0100, Jonathan Cameron wrote:

> In the long run I agree it would be good.  Short term there are more instances of
> struct pmu that don't have parents than those that do (even after this series).
> We need to figure out what to do about those before adding checks on it being
> set.

Right, I don't think you've touched *any* of the x86 PMUs for example,
and getting everybody that boots an x86 kernel a warning isn't going to
go over well :-)
