Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904A36D659C
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Apr 2023 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjDDOkr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Apr 2023 10:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDDOkq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Apr 2023 10:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBE1E51;
        Tue,  4 Apr 2023 07:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5962B6351F;
        Tue,  4 Apr 2023 14:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBB4C433EF;
        Tue,  4 Apr 2023 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680619244;
        bh=kJs2FcJMOyFP6Jf9o+j82QnGRlSZKmBzBCteDbxYsXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YuEvT3Dc+BynuOi7RdV3awmvLg9JsgbBy8E7i9AWMgfcUA5Q69kszLaCOceYC+28H
         6af20+rJGuKZ9+JU076ksTIH8Z3r8vN1AdJLPpeZxhH1XTHfTLKxrZ+eaPttJP45Y1
         NeZNVeqBlCnssVHKmlHDm2xXXuPYwA7s9rdCGuiY=
Date:   Tue, 4 Apr 2023 16:40:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Dan Williams <dan.j.williams@intel.com>,
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
Subject: Re: [PATCH 00/32] Add parents to struct pmu -> dev
Message-ID: <2023040423-hungry-cadet-1fc1@gregkh>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Apr 04, 2023 at 02:41:53PM +0100, Jonathan Cameron wrote:
> These are the low hanging fruit following GregKH's feedback that
> all the devices registered via perf_pmu_register() should have parents.
> 
> Note that this causes potential ABI breakage.
> 
> It may fall in the category of it isn't breakage if no one notices
> but I can't be certain of that.  Whilst it is arguable that
> no one should be been accessing PMUs except via the event_source
> bus, there was documentation suggesting /sys/devices/ for particular
> PMUs (because it was a shorter path?)
> 
> The first patch is pulled out of the series:
> https://lore.kernel.org/linux-cxl/20230327170247.6968-1-Jonathan.Cameron@huawei.com/
> [PATCH v3 0/5] CXL 3.0 Performance Monitoring Unit support
> 
> In that particular case it is very useful to be able to figure out which
> CXL device the PMU device is associated with and looking at it's parents
> in the device model as shown with ls -lh /sys/bus/event_sources/devices/
> is a very easy way to do this (once it is correctly parented).
> 
> Addressing all the other instances of struct pmu not covered by this series
> is likely to be a more complex discussion but unlikely to have an affect
> on what is proposed here.
> 
> Documentation updates deliberately 'fixed' in separate patches before
> changing the path to highlight that using /sys/bus/event_source/devices
> path is unchanged by this series and that is presumed to be the
> most common way these files are accessed.

For the whole series, looks good:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
