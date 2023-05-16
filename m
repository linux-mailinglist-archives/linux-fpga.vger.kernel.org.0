Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D3770563A
	for <lists+linux-fpga@lfdr.de>; Tue, 16 May 2023 20:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjEPSn1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 May 2023 14:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEPSnY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 May 2023 14:43:24 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76437ED5;
        Tue, 16 May 2023 11:43:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4894B6E3;
        Tue, 16 May 2023 18:43:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4894B6E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684262602; bh=2nn46iH/XNrV/RzViG7SDL3cvowctVdv4ESxisOfTVc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sQCycDXWryc7kh/GwxTnIiEE9BBQ5Wg0qYxf6qGYUjxewtfWlm9PJr71sk4v4Di6R
         3NOETyzqP4ciTPdG7vyWitXc4LvVvgjZomPlva8sqjYdc7gMJfDPeYkL2JQfDVBp4E
         QeDKotTL45wNzzIeL4Q5/lNHUzT8BZBl6PYijhIX5mLIxTVJx+jSWNa7TjVv8qhFwv
         gQ+Opp9MG3pw0FIbR0egxl2f2CaM6AElGBY5sjqN2mECK4bdZ7S7Y8XsOICiEvyzwA
         q2FVFuSgFwkaa7wwnsVMeCYBWPMf0UJFKHATxx9ENWMlQq5Bjcwer/iHKbYG/8VeFW
         nfgQkaZdb/0UQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, Phillip Potter <phil@philpotter.co.uk>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Documentation: use capitalization for chapters and
 acronyms
In-Reply-To: <20230516001518.14514-1-rdunlap@infradead.org>
References: <20230516001518.14514-1-rdunlap@infradead.org>
Date:   Tue, 16 May 2023 12:43:21 -0600
Message-ID: <87v8gsazhy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Use capital letters in acronyms for CD-ROM, FPGA, and PCMCIA.
>
> Use capital letter in the first word of chapter headings for
> Locking, Timers, and "Brief tutorial on CRC computation".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-fpga@vger.kernel.org
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/cdrom/index.rst   |    6 +++---
>  Documentation/fpga/index.rst    |    2 +-
>  Documentation/locking/index.rst |    2 +-
>  Documentation/pcmcia/index.rst  |    2 +-
>  Documentation/staging/crc32.rst |    2 +-
>  Documentation/timers/index.rst  |    2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

jon
