Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F226F07EB
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Apr 2023 17:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbjD0PGb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Apr 2023 11:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjD0PGa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 27 Apr 2023 11:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9098735A5;
        Thu, 27 Apr 2023 08:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B73663925;
        Thu, 27 Apr 2023 15:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C019C433D2;
        Thu, 27 Apr 2023 15:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682607988;
        bh=XXwkZnWg6KYMFWjDkqQ3dNOs6dgSDcXntYmClxHWoHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FH6J4C28XuZZSHRakWFjgzkLlPB0djx7/A3cjwhw4ayYG45xQeK764pcLsHfKneEy
         Ft0UMrf4FX0M02ZHapHM38DQh8pimTJQBG5LH9LfiXPQxIoOBi2Fc6AV8J4QGyC9Ke
         vgXxZL/8PcMQBOIae6WOz9wNEnF1ZTK4hosv3emLSFFDeKa7luvdqWqwVarmMz7rgf
         NAQlScgvFoCNFaQSb+gSYvVV1EKiW3ObZ5eMJNNs/UDZlWziFShQc6MwomiMwVbrTp
         pgEMtpPLzsh4NLBh+gQaIyar/kw8welCqW4nzidEceaoxavMCUWMNYDKw1FrTrS+Mp
         ANhT37GkHHxrA==
Date:   Thu, 27 Apr 2023 16:06:23 +0100
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mfd: intel-m10-bmc: Move m10bmc_sys_read() away
 from header
Message-ID: <20230427150623.GU50521@google.com>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
 <20230417092653.16487-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417092653.16487-4-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 17 Apr 2023, Ilpo Järvinen wrote:

> Move m10bmc_sys_read() out from the header to prepare it for adding
> more code into the function which would make it too large to be a
> static inline any more.
> 
> While at it, replace the vague wording in function comment with more
> precise statements.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net> # For hwmon
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/hwmon/intel-m10-bmc-hwmon.c |  1 +
>  drivers/mfd/intel-m10-bmc-core.c    | 14 ++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h   | 17 +----------------
>  3 files changed, 16 insertions(+), 16 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
