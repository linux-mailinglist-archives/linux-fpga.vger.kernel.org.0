Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DFA735924
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Jun 2023 16:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjFSOFd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Jun 2023 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFSOFc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 19 Jun 2023 10:05:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C7F10F;
        Mon, 19 Jun 2023 07:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DC0860C86;
        Mon, 19 Jun 2023 14:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC40C433C0;
        Mon, 19 Jun 2023 14:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687183530;
        bh=rLk8q5hbwDTx/WgILRMDRjIbMatemAm7M9Ks/hKridA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hm5cqzKXE5zPGQlVvB1J3DvGMHezl9lhuYQ1QRwBkkzIuF0QPWCm0xzU2noma3tSP
         PKVr5FKxkbcrf+9WmYzxoZJXuxhnV9FqLp5FdodyxOLQTXHSecb8EM2y3YK5KwVkIi
         0nVo45WRBAZh5zFmABVjCeIlHJZzVRhT204ptVag=
Date:   Mon, 19 Jun 2023 16:05:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Colberg <peter.colberg@intel.com>, hao.wu@intel.com,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, aaron.j.grier@intel.com,
        tianfei.zhang@intel.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        lgoncalv@redhat.com
Subject: Re: [PATCH] fpga: dfl: afu: use PFN_DOWN() and PFN_PHYS() helper
 macros
Message-ID: <2023061908-subscribe-persuader-9b9f@gregkh>
References: <20230616224209.20991-1-peter.colberg@intel.com>
 <2023061916-abacus-dipper-2238@gregkh>
 <ZJBeJKzEXiu/aHTv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJBeJKzEXiu/aHTv@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 19, 2023 at 04:54:44PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 19, 2023 at 03:46:29PM +0200, Greg KH wrote:
> > On Fri, Jun 16, 2023 at 06:42:09PM -0400, Peter Colberg wrote:
> > > Replace all shifts by PAGE_SHIFT with PFN_DOWN() and PFN_PHYS() helper
> > > macros to convert between physical addresses and page frame numbers.
> > 
> > Is this a bugfix, or just a cleanup?
> 
> Cleanup.

Great, can the text be worded to say that?  As is, it does not give any
hint either way.

thanks,

greg k-h
