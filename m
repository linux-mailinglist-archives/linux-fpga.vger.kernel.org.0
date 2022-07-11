Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9161956FFF8
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jul 2022 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiGKLOu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jul 2022 07:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKLOd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 11 Jul 2022 07:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDAF528BB
        for <linux-fpga@vger.kernel.org>; Mon, 11 Jul 2022 03:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0908613C5
        for <linux-fpga@vger.kernel.org>; Mon, 11 Jul 2022 10:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE20DC34115;
        Mon, 11 Jul 2022 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657535508;
        bh=cfIpheh5DXRrSeW2JE/GHw/VijvHckfHAvMOJVyHb6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqkG3m8d2I9Ss0lNJkHyNnCECsONS1VDTHLT706Z2cZLLGH63r7UwajuwiMCCrikx
         hAVP+EkKQw29Rp4jafaXlkB90EsT/Ixa5r6cZETD8ENgls/7xLNrja3KI96FBn+NBE
         hV7ZrG0j7cMLLjdDx6mO8STfrtgdSyiFv8bxwly4=
Date:   Mon, 11 Jul 2022 12:31:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager late changes for 5.20-rc1
Message-ID: <Ysv8A0votdKPpb3c@kroah.com>
References: <20220711064043.GA4044494@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711064043.GA4044494@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jul 11, 2022 at 02:40:43PM +0800, Xu Yilun wrote:
> The following changes since commit 2df84a757d87fd62869fc401119d429735377ec5:
> 
>   fpga: altera-pr-ip: fix unsigned comparison with less than zero (2022-06-10 15:48:23 +0800)
> 
> are available in the Git repository at:
> 
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-late-for-5.20-rc1

Pulled and pushed out, thanks.

greg k-h
