Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7398767E1A3
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 11:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjA0K2u (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 05:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjA0K2q (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 05:28:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8B3B0D6;
        Fri, 27 Jan 2023 02:28:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4061C61AC6;
        Fri, 27 Jan 2023 10:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FD0C433EF;
        Fri, 27 Jan 2023 10:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674815320;
        bh=z2+AxmHxk5lOA00VUSDpTYAs3Y91sY7cjOC6qzZT7nU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpc1BRwp1QYXmQh2hy0B8165ksguwSlCz5iyDIKxjjyM1Vc2DPzw5DhD4C0BI4Cmi
         EKFj5sRoeayj7fdZo9G4OBEh5vPk1UIXC4Uv3WoD9OYjczBxe5F3B2Zr11nTLzSpZM
         aJwb7i3F+Hm3p62+t/qgcrkQ51zFqaBKWLycvxLSCPoibp/4aeBbtJ6LIXos9aPR2b
         sXBj5iRxixhGo3XqmH+TtE+ivzMFoRXN/wTQ3VOvdfPrmjq98Po189cqYgNks0UKwn
         4/eLI6ZzYRPN9lJzsUp1/RxTTvvbzXKiNBRGfVhRYcu/5P2vqsLXkGlvDENjxpuQos
         BbCuQJWvz5JXA==
Date:   Fri, 27 Jan 2023 10:28:34 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/11] mfd: intel-m10-bmc: Create m10bmc_platform_info
 for type specific info
Message-ID: <Y9OnUjLVFt4o2E97@google.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <20230116100845.6153-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230116100845.6153-3-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 16 Jan 2023, Ilpo Järvinen wrote:

> BMC type specific info is currently set by a switch/case block. The
> size of this info is expected to grow as more dev types and features
> are added which would have made the switch block bloaty.
> 
> Store type specific info into struct and place them into .driver_data
> instead because it makes things a bit cleaner.
> 
> The m10bmc_type enum can be dropped as the differentiation is now
> fully handled by the platform info.
> 
> The info member of struct intel_m10bmc that is added here is not used
> yet in this change but its addition logically still belongs to this
> change. The CSR map change that comes after this change needs to have
> the info member.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/mfd/intel-m10-bmc.c       | 53 ++++++++++++++-----------------
>  include/linux/mfd/intel-m10-bmc.h | 12 +++++++
>  2 files changed, 36 insertions(+), 29 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
