Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C134F20B47F
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Jun 2020 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgFZP2F (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Jun 2020 11:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgFZP2E (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 26 Jun 2020 11:28:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37C7207E8;
        Fri, 26 Jun 2020 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593185284;
        bh=9bZucUVhPKbtDN9cK4HYBTQpBZCh32rteVQs7hV98yY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ov/PmEE16IWJxfammoeLDBbVsZr7zgt07XFF+uNZ9AMHtz9bq0BVbeutyzlgsDc18
         hdgiZir/u9T34BXKwYeANex8oHAdBJTc7Nom8fiXN308RDHNmA413D9/YsB7PXgHBK
         8yjMhuPMWKMUEvBAheLaaPHHh2jH8MQQdWjteXFA=
Date:   Fri, 26 Jun 2020 17:27:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager (late) fixes for 5.8
Message-ID: <20200626152759.GA1425473@kroah.com>
References: <20200609154800.GA16679@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609154800.GA16679@epycbox.lan>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 09, 2020 at 08:48:00AM -0700, Moritz Fischer wrote:
> The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:
> 
>   Linux 5.7 (2020-05-31 16:49:15 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-fixes-for-5.8

I just realized that linux-fpga is not on lore.kernel.org, any reason
why not?  That meant I couldn't use 'b4' on this :(

Anyway, now pulled and pushed out, thanks.

greg k-h
