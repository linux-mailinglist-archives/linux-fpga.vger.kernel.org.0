Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CAD5BFEF2
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Sep 2022 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiIUN2m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Sep 2022 09:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiIUN2k (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Sep 2022 09:28:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53D190C5B
        for <linux-fpga@vger.kernel.org>; Wed, 21 Sep 2022 06:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E1562566
        for <linux-fpga@vger.kernel.org>; Wed, 21 Sep 2022 13:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F2C433C1;
        Wed, 21 Sep 2022 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663766918;
        bh=styeL4qwT+9oImoa5fW7BSEPQTP5Cs/8eQCnPSMpHWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AgERkJ3mKAGle8O5GFAtMvxub4XlYO5AsX0zlXGAzK0DB9+r8M7psjUdEwAbh/pxB
         l6k3/cVGJJ74F7CMbMwWGGSxMI52GAjdbk0plKSBsyPkE2Qs57BBG85Bhbl1IYk4Mw
         2ebp0irUwFis1DeRATRHSdw8vsfZ7PRczmZPZfIw=
Date:   Wed, 21 Sep 2022 15:28:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.1-rc1
Message-ID: <YysRgw/dERtMUBtz@kroah.com>
References: <YygCSm7btA1pkKdk@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YygCSm7btA1pkKdk@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Sep 19, 2022 at 01:46:50PM +0800, Xu Yilun wrote:
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.1-rc1
> 
> for you to fetch changes up to 562d0bf2cab80810fa50a1f109a6bdb61c25efc2:
> 
>   fpga: m10bmc-sec: d5005 bmc secure update driver (2022-09-11 15:36:35 +0800)
> 
> ----------------------------------------------------------------
> FPGA Manager changes for 6.1-rc1
> 
> DFL
> 
> - Matthew's change adds new device IDs supported by DFL.
> - Dan's change uses array_size() for memory allocation to prevent
> potential overflow
> 
> Microchip
> 
> - Conor's change adds MODULE_AUTHOR entry for microchip-spi driver
> - Krzysztof's change refines dt-bindings
> 
> Intel m10 bmc secure update
> 
> - Russ's change adds new device ID supported by the driver

In the future, new ids can be added to stable kernels.

thanks,

greg k-h
