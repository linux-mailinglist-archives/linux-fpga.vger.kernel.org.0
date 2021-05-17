Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D4D3823B8
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 07:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhEQFcB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 May 2021 01:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232343AbhEQFb7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 May 2021 01:31:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACFAD6101B;
        Mon, 17 May 2021 05:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621229444;
        bh=EVT4AdU8eYMpp2KsK2o3DqxX6S99/LjsvVK2OX1GX/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWjeEyF0HJTZGCQUcBAMdWINRio8uyiFOx0L2rzx8rnc8Hc5sd8fKpR7CLgTuiRhQ
         YceB24+fuvtwNX84Cy7E/fxfK5xkqEOfunddXmrj+VuP2RQo6YKOiEX6mktWMM6XCW
         h/iIoa6y6WnfMY9uNwNBX4nwpjikD1TtGQOPVd0c=
Date:   Mon, 17 May 2021 07:30:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH 08/12] fpga: m10bmc-sec: create max10 bmc secure update
 driver
Message-ID: <YKH/fwAOVW0gLQvQ@kroah.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-9-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517023200.52707-9-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, May 16, 2021 at 07:31:56PM -0700, Moritz Fischer wrote:
> From: Russ Weight <russell.h.weight@intel.com>
> 
> Create a platform driver that can be invoked as a sub
> driver for the Intel MAX10 BMC in order to support
> secure updates. This sub-driver will invoke an
> instance of the FPGA Security Manager class driver
> in order to expose sysfs interfaces for managing and
> monitoring secure updates to FPGA and BMC images.

No, please NEVER create a platform device for something that is not
actually a platform device.  That's a huge abuse of the platform device
code.

Please use the proper api for this if you need it, hint, it's NOT the
platform device code.  Your Intel reviewer should have told you what
it is when they saw a changelog comment like this....

greg k-h
