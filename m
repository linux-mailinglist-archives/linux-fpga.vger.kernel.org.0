Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5583636919
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Nov 2022 19:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiKWSh2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Nov 2022 13:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbiKWShT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Nov 2022 13:37:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB1062DD
        for <linux-fpga@vger.kernel.org>; Wed, 23 Nov 2022 10:37:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D46CFB82259
        for <linux-fpga@vger.kernel.org>; Wed, 23 Nov 2022 18:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D37BC433C1;
        Wed, 23 Nov 2022 18:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669228636;
        bh=b6cBdFveLPp2oyhztLFImf5oR7iBF/kSQRKXR5PB1O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qac2C3HCP2RuDtKo8CVUh7++/oSoat/T4JudTwoxmcYsru+J4l435Cvb0NJNO0UMF
         4I5TKdDbCq6NYvy7A3DVIRIpGZy9dixFHSMuSIE8yzPT8GBWniV1Q56/dCHxkF2Oo3
         OzUU+AY9QdQtqybfIC0dX83EXKu97BqW8JQmfsHU=
Date:   Wed, 23 Nov 2022 19:37:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.2-rc1
Message-ID: <Y35oUu3lcwuXe49F@kroah.com>
References: <Y3Ofqbmsbn8q4Ksb@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Ofqbmsbn8q4Ksb@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 15, 2022 at 10:18:17PM +0800, Xu Yilun wrote:
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:
> 
>   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.2-rc1

Pulled and pushed out, thanks.

greg k-h
