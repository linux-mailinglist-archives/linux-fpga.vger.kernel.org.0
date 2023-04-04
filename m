Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D806D63F5
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Apr 2023 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbjDDNvR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Apr 2023 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjDDNvN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Apr 2023 09:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A867A44B2;
        Tue,  4 Apr 2023 06:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34A7E63440;
        Tue,  4 Apr 2023 13:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170C9C4339B;
        Tue,  4 Apr 2023 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680616270;
        bh=M01kLJmuFwVJVH5Fd0jHURY66CemX7oncliKZevP7g0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZw4cbD5umDKL/ZgCvOKS5mpwCGR1BQ72STMVfgjCvL67KREjRVIEZmqVvDB8kqED
         bGD9pkjFw8YLyi8S10/+HeO11YvX1wNqbgoqIA2MhWfZYy+uphB+8exKR4ZUng1kj7
         dIOuCdpMDWX3ARB9MwpySfrJKcHrjLWNdsjdNd/8=
Date:   Tue, 4 Apr 2023 15:51:07 +0200
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
Message-ID: <2023040447-music-purgatory-1985@gregkh>
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

devices can always move around /sys/devices/ as there is not a guarantee
that they will ever be in the same place.  That's what /sys/class/ is
used to find (and /sys/bus/ in some cases.)

And even then, the naming scheme is variable, and can and will change
(i.e. bus ids), so that too is not required to stay the same.

thanks for doing this work, I'll add it to my review queue...

greg k-h
