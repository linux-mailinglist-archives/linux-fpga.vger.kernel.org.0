Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41317CC974
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Oct 2023 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjJQRD6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Oct 2023 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQRD5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 Oct 2023 13:03:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A0B0
        for <linux-fpga@vger.kernel.org>; Tue, 17 Oct 2023 10:03:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3CCC433C8;
        Tue, 17 Oct 2023 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697562236;
        bh=1NzJgCt8ZJpdh0tQ6dPDmpSAOpsmugSjAcC9Ld+IxSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XFWg2RMdNM2CjAqEgaLjVpeTtOmKcCsYm9xsOuKKzfg0fybgTxQ1RyBrG+R49lqE9
         CGXKR1kThTD068BhFPZSknsxJYsTJzMJ2zBklAzExb9ds3Wuatc9oW/lCenj6nlt8I
         b3xWvElmHVHlpsZOmNjbWQzhgD75H9WLCext95HU=
Date:   Tue, 17 Oct 2023 19:03:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.7-rc1
Message-ID: <2023101740-unwritten-obtain-1867@gregkh>
References: <ZS6kFqfbqbR5mdO+@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6kFqfbqbR5mdO+@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 17, 2023 at 11:11:18PM +0800, Xu Yilun wrote:
> The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:
> 
>   Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.7-rc1

Pulled and pushed out, thanks.

greg k-h
