Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28E49A40
	for <lists+linux-fpga@lfdr.de>; Tue, 18 Jun 2019 09:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfFRHRz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 18 Jun 2019 03:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfFRHRz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 18 Jun 2019 03:17:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21CFC20679;
        Tue, 18 Jun 2019 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560842274;
        bh=gEZIWfSOuWSYvHeslOMpZAj8awrdOD0XeQd46740XIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SR2zTKt9NEzCCluJkxlhVi2rFZbbvqHYE93i10IRn7t74A9kfSBuV+jx2qcH2+HD3
         xievCMWBg/HaUfv7LqW6fJMN0tqMB5agUi9ckFzn/qCCW3d33wipTAS+y0V6yslmxs
         Yw7oNOrtK2W4bLRHRf1Bmn7MfVpT9ILlqYQCEk5Y=
Date:   Tue, 18 Jun 2019 09:17:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Richard Gong <richard.gong@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fpga: hand off maintainership to Moritz
Message-ID: <20190618071751.GA4159@kroah.com>
References: <20190617031113.4506-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617031113.4506-1-atull@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Jun 16, 2019 at 10:11:13PM -0500, Alan Tull wrote:
> I'm moving on to a new position and stepping down as FPGA subsystem
> maintainer.  Moritz has graciously agreed to take over the
> maintainership.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>

Thanks for all the work you have done on this subsystem getting it into
mergable shape and then maintaining it for a while.

good luck on your future endeavors, hopefully it still involves kernel
programming :)

greg k-h
