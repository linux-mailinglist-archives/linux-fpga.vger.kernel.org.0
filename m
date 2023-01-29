Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD8B67FE99
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Jan 2023 12:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjA2Lg7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 Jan 2023 06:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2Lg7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 29 Jan 2023 06:36:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D1A1DB90
        for <linux-fpga@vger.kernel.org>; Sun, 29 Jan 2023 03:36:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B83DE60CFB
        for <linux-fpga@vger.kernel.org>; Sun, 29 Jan 2023 11:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED76C433EF;
        Sun, 29 Jan 2023 11:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674992217;
        bh=QXxLre1Fig6fReSzjpcK9XrsK6Ds4NBn2dninOxxXbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aowvSIE2Izua6pOnSjt1oLN9DN/EnrfOq5aI4xX3qTQjpK9Wznr4+IImnghXKhKzy
         XsDlAGP0ucANntWWCW9+1toy/DedtXQZDSQry4kZ8qcG8vLRuM8GyMsFNkzmXV2JRs
         lRlRiZOblmJ/gwO9z2kQIfX6VmwHcRgaA9xFN+rk=
Date:   Sun, 29 Jan 2023 12:36:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.3-rc1
Message-ID: <Y9ZaLfcrG0WxkKhu@kroah.com>
References: <Y9ZH6EhbFCRvoFXx@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9ZH6EhbFCRvoFXx@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Jan 29, 2023 at 06:18:16PM +0800, Xu Yilun wrote:
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-v6.3-rc1

Pulled and pushed out, thanks.

greg k-h
