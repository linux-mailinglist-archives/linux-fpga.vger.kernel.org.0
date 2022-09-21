Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699B35BFF1C
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Sep 2022 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIUNne (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Sep 2022 09:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiIUNnc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Sep 2022 09:43:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362856D567
        for <linux-fpga@vger.kernel.org>; Wed, 21 Sep 2022 06:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4AC462BAA
        for <linux-fpga@vger.kernel.org>; Wed, 21 Sep 2022 13:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E53C433D6;
        Wed, 21 Sep 2022 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663767810;
        bh=mMHosWR7N5bgXiafaH8RVMGWb8YjHAmwJmfj1XOJhC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ruELcKbfBB96CgIYPSazn2HIDFjzc7sEZ7wP2qZTqkVn7GzUIN2U2uHdVe0Kjbon
         GvP6hHaNXbZbB7tDKyxE6vhkX3dssSsOTJOBz6YcZ6l2UQy1B1yxUxOzXnkRFlhPuX
         UISB0l4jVZ4rp1AswgrIkQP5gBKY9cmkTDerQU3Y=
Date:   Wed, 21 Sep 2022 15:43:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.1-rc1
Message-ID: <YysU8H1/Vhsz13cI@kroah.com>
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

Pulled and pushed out, thanks.

greg k-h
