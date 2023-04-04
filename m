Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDB36D644A
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Apr 2023 15:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjDDN4R (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Apr 2023 09:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbjDDNwY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Apr 2023 09:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01BE35BD;
        Tue,  4 Apr 2023 06:52:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7814E63451;
        Tue,  4 Apr 2023 13:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621DCC4339B;
        Tue,  4 Apr 2023 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680616329;
        bh=n1dnFX90RVZwjgGZApDoi0l4kUa7bOXawzIZSMZM4HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgq8ZzFX/jkLL6p/XHEUWayiCcLXg9GvKET5tYGV9nyns/uphG8a84bLxGQVdQLr7
         VnvZW2av4LoT0NiJbu3p9Aww8h/PWFZN6Aa0mdaCqzaaOb8YSqqWuSgmDMhks7fRLZ
         J+b6jRazb0FLnQcm2sqDMUpww03eaegzCR2vtWgY=
Date:   Tue, 4 Apr 2023 15:52:07 +0200
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
Subject: Re: [PATCH 03/32] Documentation: hisi-pmu: Drop reference to
 /sys/devices path
Message-ID: <2023040401-cuddle-mandolin-7e19@gregkh>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-4-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404134225.13408-4-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Apr 04, 2023 at 02:41:56PM +0100, Jonathan Cameron wrote:
> Having assigned a parent to the device, the suggested path is
> no longer valid.  As /sys/bus/event_sources based path is also
> provided, simply drop mention of alternative.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
