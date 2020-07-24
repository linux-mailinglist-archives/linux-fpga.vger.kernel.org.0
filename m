Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180FF22BC4E
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Jul 2020 05:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgGXDEC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Jul 2020 23:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGXDEC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 23 Jul 2020 23:04:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1B9C0619D3;
        Thu, 23 Jul 2020 20:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Bkjf0CIjG+04GJ1x/Bn4xTvGvn1CQ2PafE9rcjMKdes=; b=CHcYskn9xYfy1pXPgXpf/V6HQF
        PHfWhfVfTGM2mPUbpzMsE9bDxE31DqHbWroUmE/COHuStmeIDtWRq0ne8yPNgVdXICtEY1elQ1ZNH
        WX8zatzewbn8hJEGOpD8YqmJelUgoHPx+bk8RKdFZ9rNc4yFxwR1U3snUG9r0S69zETAAdP7jwBRp
        X7Qq6YreokoQiiScgamZtUevV7NOZZFL0nWoCgvoUheMh3Z4SrMRXtWuVZGpLFbkzKF8dBO2XBubL
        PT4wqeLfj8RF6AjRDsVZHXoaCXUgmRPpAyB/b5BoskMk1KfEWmuLlN7TKg8lg2N0jjP34n4CabbdB
        ioae9HaQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyo04-0007d6-H1; Fri, 24 Jul 2020 03:03:57 +0000
Subject: Re: [PATCH v2 0/4] Modularization of DFL private feature drivers
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7ff4653b-dcf0-e7d4-9d09-a30a9f857661@infradead.org>
Date:   Thu, 23 Jul 2020 20:03:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 7/23/20 7:09 PM, Xu Yilun wrote:
> This patchset makes it possible to develop independent driver modules
> for DFL private features. It also helps to leverage existing kernel
> drivers to enable some IP blocks in DFL.
> 
> Patch #1: An improvement of feature id definition. The feature id will be used
> 	  as the key field for dfl device/driver matching.
> Patch #2: Release the dfl mmio regions after enumeration, so that private
> 	  feature drivers could request mmio region in their own drivers.
> Patch #3: Introduce the dfl bus, then dfl devices could be supported by
> 	  independent dfl drivers.
> Patch #4: An example of the dfl driver for N3000 nios private feature.
> 

Hi,
What is "nios"?  Is that explained or described anywhere?

> 
> Main changes from v1:
> - Add the new Patch #1, to improve the feature id definition.
> - Change the dfl bus uevent format.
> - Change the dfl device's sysfs name format.
> - refactor dfl_dev_add()
> - Add the Patch #4 as an example of the dfl driver.
> - A lot of minor fixes for comments from Hao and Tom.

thanks.
-- 
~Randy

