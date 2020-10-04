Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE0282C81
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 20:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgJDS1L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 14:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726288AbgJDS1L (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 14:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601836030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LRQl9XAzZFambWWfa1t/YIDaxIxtogTwQJZ8ypXJV2k=;
        b=UWGxbEQYcAp+jsLrRN4pu0C56PFHsBb4GJ2oZBtOAWRqgf1gZUwwBJccp1qhOWEnhzAH8w
        oR+jPv4tScCdAijuAOx2BHZXi0Bwa0J6wLnIlbIrFvpszlc9r6HzxgKiOrKVzJitnmL9VF
        EMl1j3Kf1Hcsrsu3oONHmn7PFNGGlk4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-9_c30LZ6P4O4hja9luySlw-1; Sun, 04 Oct 2020 14:27:09 -0400
X-MC-Unique: 9_c30LZ6P4O4hja9luySlw-1
Received: by mail-qv1-f69.google.com with SMTP id j4so385191qvn.0
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 11:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LRQl9XAzZFambWWfa1t/YIDaxIxtogTwQJZ8ypXJV2k=;
        b=CtM7OBYilrYM/dslGBHw56EBxcCl+H9+jSOHpxQtZraEPhtLn+lE0CLj/DE5/a+QBI
         6JZnamk1D2rOmlBOwiaGgtES8ieZ8HG2uOrnU5+s58m9+AnA42+wSUavXdAGE1Bk9eBr
         J7F/3E3weQcXCS+tAGneS7p9AugoeCYDR75ak68MZ5J8DbNhpC7NVy91mORzm1mTRLBZ
         H/fMwbtDe1Eqsgk89T6ljO/APMBepEsiJa4Kipf63L0tnXshF+HlYoPHN/1q15lulR/A
         02zBIsyoZkaeh312OgCK/dQQ26Kz238kSEC8+61hUqfg607u9RE9bWgUn6Wg/F3twmLn
         QMgQ==
X-Gm-Message-State: AOAM530VOQRsPwPf7Q/l9ZhbqdZIdqq9+ELs0ltXg6Mcn5e8hqxo74pp
        fP13TeM9sc+y6Z0OYL0xSVm/i99QLsX6RKc87IYFH//lEyy/apkpDSQTl9DpSBIPvhmvDIYTq7F
        SIByFwq3EPrSpbpDEqqIXAA==
X-Received: by 2002:aed:3bf1:: with SMTP id s46mr10841055qte.389.1601836028656;
        Sun, 04 Oct 2020 11:27:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1UvFJemFurXd2fHmgTbIaJjJqD+inZL1Ib10s1CMDYG6SC8FkssSFScQa/ApUQ9uCXbKXDA==
X-Received: by 2002:aed:3bf1:: with SMTP id s46mr10841036qte.389.1601836028474;
        Sun, 04 Oct 2020 11:27:08 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f2sm6063344qta.37.2020.10.04.11.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:27:07 -0700 (PDT)
Subject: Re: [PATCH 06/10] fpga: fpga-mgr: socfpga: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-7-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <bfbfe582-ffeb-5a34-b189-3ad8ba22a05b@redhat.com>
Date:   Sun, 4 Oct 2020 11:27:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-7-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/3/20 10:14 PM, Moritz Fischer wrote:
> Simplify registration using new devm_fpga_mgr_register() API.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/socfpga.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

LOTM

Reviewed-by: Tom Rix <trix@redhat.com>


