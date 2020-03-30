Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2502D197E20
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Mar 2020 16:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgC3OPJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Mar 2020 10:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgC3OPJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 30 Mar 2020 10:15:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB3E20780;
        Mon, 30 Mar 2020 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585577708;
        bh=ZwSWcJRMvlTAmlgYyjHyDdVg0krz9lb44IX90d0jZ4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjB581ZufcDVYW4zmPY5FLQOLu0KfVsl7mSOIbgVbPsiOThFZVR/YlkjEKBHzgQXs
         e9TUL+7n7B2/Y0wknwjWLPrV0SzkPI7j8ZBfiD7c6EB5lfcRxj52zjOAZyvnU/UIjL
         TKH3oiwbtz8k3UR2095QauOlxthtyFrV0/FBhPb4=
Date:   Mon, 30 Mar 2020 16:15:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     moritzf@google.com, linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 5.7
Message-ID: <20200330141506.GA438143@kroah.com>
References: <20200327162944.GA4118@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327162944.GA4118@epycbox.lan>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Mar 27, 2020 at 09:29:44AM -0700, Moritz Fischer wrote:
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> 
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-for-5.7
> 
> for you to fetch changes up to 3d5a5417ad064a6ca64a33f0c554d917311c79f4:
> 
>   fpga: dfl: afu: support debug access to memory-mapped afu regions (2020-03-21 13:14:30 -0700)

This is too late for 5.7-rc1 as stuff needed to be in my tree last week
(and not Friday), to give it time to test in linux-next.

Care to break this up into two trees, stuff for 5.7-final with bugfixes,
and stuff for 5.8-rc1?

thanks,

greg k-h
