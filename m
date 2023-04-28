Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE76F111C
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Apr 2023 06:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjD1Epx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Apr 2023 00:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjD1Epw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 28 Apr 2023 00:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D926A1;
        Thu, 27 Apr 2023 21:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 885D0640A4;
        Fri, 28 Apr 2023 04:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6886FC433D2;
        Fri, 28 Apr 2023 04:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682657151;
        bh=7rszxrAAfy8VU8gN+K5tak5zsE1EJudMdjmMp2s2PMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8i2zLn+IxVuWGsQokgx/J2kK75hsTheE1aH5EQO56h++q5CWSM8KodAO7Wt8yFa0
         XtGI08wsN35V8b3uOv8alEVOarm4TCR8y5t/eYr2NnO3IIGX2T9oAuL/u7rubssfUK
         Oh/Io340l7vyubUTHfttTK27hOxuV1sQ+UuaORlo=
Date:   Fri, 28 Apr 2023 06:45:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: update Microchip MPF FPGA reviewers
Message-ID: <ZEtPe-3MUZV0AQgF@kroah.com>
References: <20230426073519.9167-1-i.bornyakov@metrotek.ru>
 <20230426073519.9167-2-i.bornyakov@metrotek.ru>
 <20230427-episode-overdrawn-ed2d1d30cb34@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427-episode-overdrawn-ed2d1d30cb34@spud>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 27, 2023 at 04:28:23PM +0100, Conor Dooley wrote:
> Hey Ivan,
> 
> On Wed, Apr 26, 2023 at 10:35:18AM +0300, Ivan Bornyakov wrote:
> > As I'm leaving Metrotek, I'll have no access to the hardware and my
> > Metrotek email will be off soon.
> 
> Good luck so!
> 
> > Replace my email with Metrotek System
> > Team collective inbox.
> 
> Hmm, I am not too sure about this. I've previously seen the likes of
> Greg KH frowning on these sort of shared mailboxes.

Yes, shared mailboxes mean no accountability and responsibility.  Please
don't do that.

thanks,

greg k-h
