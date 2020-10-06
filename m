Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FEB285107
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Oct 2020 19:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgJFRlU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 13:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgJFRlU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Oct 2020 13:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602006079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NBwYPLORlbVcrvKPyGk/TLmMoRjEUUqSOuonzOzquE=;
        b=KqGpKKVXM/0FWUN0vC/8HsYp929k9I3bg+mjj/fs3Mwb27WMJnhGeyCUXpwHt4VGjfHaV2
        LLJ+GJDHnAgjQggZulj+7AWiNxTAQ07Yv6uBVbgsfgsO5+5nzA0iuwCPBhI/Hv7Eq5nxpk
        wIuDqR5JBZNTGO71kI1rT2+Ma0lbh5A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-LPzmNhhfMhSL2KNz4TVUzQ-1; Tue, 06 Oct 2020 13:41:18 -0400
X-MC-Unique: LPzmNhhfMhSL2KNz4TVUzQ-1
Received: by mail-qt1-f197.google.com with SMTP id u6so9581408qte.8
        for <linux-fpga@vger.kernel.org>; Tue, 06 Oct 2020 10:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/NBwYPLORlbVcrvKPyGk/TLmMoRjEUUqSOuonzOzquE=;
        b=t84oGPDXdvQPHf4jjqZORPN4xjmHrNnuS40xYJb4y2JvY5vV8r2hGqpR0+3r7WhyzC
         OEWfigh+stTHkAw/h4teyQrn7Z8Vct9Baa2KmqR2JisdZhdoaW+yb4hmuIUdnitvuRub
         WDH3E2XAOVj4fgnZ/hkL6Iw3+kiRX4IKKAik9AsOGarqRze3VF3gkP4OT/KhTlZ0P/Pq
         FuIX4uSXAOCyCyWlhUotVmeNZJPWtOC48Y23qay/c9RVr4o/gLvAwnp8GbDVzPZ7d9hE
         9hznWPkDhsSBoGt3IXZ3gawxsLN95qi/O2igs8K0C5O3Z2dDiCg7D+BXDQ9D278EzDAn
         PJaw==
X-Gm-Message-State: AOAM5305qLlkrz/JOf6S20GJfXFgFWmwqk1t9mRey7Wsr8MstM6IprPl
        1xY/fwDtJlfmUv5+U1FXegBvnNf5pm/vytgJdAoc2N094rcFLOV6rrv0hIZY99VUR4iglRJ8nXa
        ylF//lxB8tt++CNBbTFl4iw==
X-Received: by 2002:a05:6214:11e4:: with SMTP id e4mr5307482qvu.61.1602006077760;
        Tue, 06 Oct 2020 10:41:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC6rrp56pJXHOW9M6RqEWmLm8gFLjcXWx1QR+BnWTFNsu+NoKfwHWuyOTRiXvlpY57S0kp2w==
X-Received: by 2002:a05:6214:11e4:: with SMTP id e4mr5307457qvu.61.1602006077580;
        Tue, 06 Oct 2020 10:41:17 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k37sm1332044qta.27.2020.10.06.10.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 10:41:17 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] fpga: m10bmc-sec: expose max10 canceled keys in
 sysfs
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-5-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b069fd5d-de9f-8d20-e3fb-e4d737032fb3@redhat.com>
Date:   Tue, 6 Oct 2020 10:41:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201003012412.16831-5-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/2/20 6:24 PM, Russ Weight wrote:
> Extend the MAX10 BMC Security Engine driver to provide a
> handler to expose the canceled code signing key (CSK) bit
> vectors in sysfs. These use the standard bitmap list format
> (e.g. 1,2-6,9).
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Replaced small function-creation macros for explicit function
>     declarations.
>   - Fixed get_csk_vector() function to properly apply the stride
>     variable in calls to m10bmc_raw_bulk_read()
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure

Looks ok to me.

Reviewed-by: Tom Rix <trix@redhat.com>


