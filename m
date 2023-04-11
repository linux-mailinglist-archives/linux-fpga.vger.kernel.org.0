Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5013F6DD493
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Apr 2023 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjDKHnw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Apr 2023 03:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjDKHnQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Apr 2023 03:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E554E421B
        for <linux-fpga@vger.kernel.org>; Tue, 11 Apr 2023 00:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D085560B2F
        for <linux-fpga@vger.kernel.org>; Tue, 11 Apr 2023 07:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1C6C433EF;
        Tue, 11 Apr 2023 07:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681198964;
        bh=SsfSKKlEGTBBFUJvQoxivKOboFQUzD2xOuHDeNA718k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edGKejYPqDiYC5uyZlM0G7h9AZkBendFBAB24XZ4JMEtQHoaVllno1S6Cxar5R6EW
         S3WJE8/sE9eABOLXPzyumLZqUoRCPFnobRyiWy904e9tBZ48xzsWqCqz7vkiMcQW0K
         tr2PzM451YLYp6pI7P52Tggd3PJ+4P3CI27ccPeM=
Date:   Tue, 11 Apr 2023 09:42:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.3-final
Message-ID: <2023041126-paternity-annotate-5799@gregkh>
References: <ZDVxpv10vXppm8T/@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDVxpv10vXppm8T/@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Apr 11, 2023 at 02:41:42PM +0000, Xu Yilun wrote:
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.3-final

Pulled and pushed out, thanks.

greg k-h
