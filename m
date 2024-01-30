Return-Path: <linux-fpga+bounces-183-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC7842859
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Jan 2024 16:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CACADB29395
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Jan 2024 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A48685C56;
	Tue, 30 Jan 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEC0Ca5e"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD360B9C
	for <linux-fpga@vger.kernel.org>; Tue, 30 Jan 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629749; cv=none; b=fatRZYGCU/DE+BDHxEf1KlhmPR4YK6dOUEVb0VmT5PcU+ETls6HK/3B+ty0/5l/Rgg83PLbNErT3J2Scj+wduw9xevIDfeNiXBOx1wm0eqvGKwxp2r0yFjtqRHQ75HZLC55r3wC40ZcQm/ZEfSdxwABLYS3tBaQeeDgZWo6xSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629749; c=relaxed/simple;
	bh=pTA0YMokaA0OHcx03bR1lxoroP4wL9uAc1cyu07K0qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTTd8FFx6ea8U8K0dPXpGiEBqO8lBPPBjquLP32oicznry5lB06vEPhT7T10OVu3LU/dKwOZappW4eMmpdRY5T39z1LhKcEzXzWHn0XAWrxnjx6W/c0uzQSCBwVzsCN3cO31EQBG8t4KSUhYtxKzdB4GNKHtlH5ewiPiCaCBCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aEC0Ca5e; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so44308565e9.1
        for <linux-fpga@vger.kernel.org>; Tue, 30 Jan 2024 07:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706629746; x=1707234546; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YilpzfeTkVydeu8rZL1Heb643X/Jk6q1uV/3UL6XRrw=;
        b=aEC0Ca5ewNdtm92avr3pSba35A8/7klAspPfWi07KLSGMa6TjVtE18SnmcacTEMlXz
         ggACP9qk3yuS1iGos21/fQYW3EV1Qblri8ixCiWrWfpy4Kc933+7mfyBOZ3m6UtySEZI
         vGAXMPtawZKdsQW6v95OqMkxDq/7wFNYb2GqiQvzLhr7x3QtgdY8zstVKUBPrWCaW/Bp
         MATMCF1LTctfTQwHHS+1nYYs/3ObnEEJscm1PaPB/VoFC4pXv8344S2VAsx5cXABSLfe
         YGZ6NBVppppGOzaBYC25xOtQk8VhFa50/JksIJoP9W7uwYBkMp1XjA26Y9jl2GBrmprM
         wVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706629746; x=1707234546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YilpzfeTkVydeu8rZL1Heb643X/Jk6q1uV/3UL6XRrw=;
        b=lC3tVNCcuGMRdz+Yr4T23P89yvqOIo6OyRQ5JaySKRoWT5Xx5hkMJcyy14nDFL2QQk
         X0JQmqowZwcoFpW9MsVRoIXxDkkXxGITTzhJwYWjSIRWaSbOX58Tr1Kkt7kZlhv9Rb7n
         bBoTf7RxULhWmBEuzHB62GrqL87Bc5TImbcekxxxWX9A/tpqgwkvAnrKId0AUpUYOZ3t
         hbl8HEyS2wsEOP4SUU6lypwGRv5ruE+0o5zYdqwtja0rC5vQVntJx82YXkCyf/W63oJS
         9sVpjU39jIERXrdVRucti9ntU7+iSs+57kA4O9+wBk3fg4lcBUT4rDJU4MCMP+ZC4tWj
         CqAA==
X-Gm-Message-State: AOJu0YxsMvjSz+oD+YLVOe7KePgwhvR7H3YffhybyugCPvlrlFu5ind0
	VOLvjTc04nWu/oypck5x8TlXedVvAzOZAp+kHPCY5kJEBmvg/peVxSCTKzOqBdg=
X-Google-Smtp-Source: AGHT+IFcHSOTOqrPAz8LjD4G2eREPrpkyWJ8wUJcJtLmYSq0P709L3wMWpvTQHOdkBEqjyVsfdwaVQ==
X-Received: by 2002:adf:f489:0:b0:33a:e9d9:5e82 with SMTP id l9-20020adff489000000b0033ae9d95e82mr5041773wro.51.1706629745960;
        Tue, 30 Jan 2024 07:49:05 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id ce6-20020a5d5e06000000b0033af3a43e91sm4434425wrb.46.2024.01.30.07.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:49:05 -0800 (PST)
Date: Tue, 30 Jan 2024 18:49:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luwei Kang <luwei.kang@intel.com>, Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] fpga: dfl: fme: Return directly after a failed
 devm_kasprintf() call in fme_perf_pmu_register()
Message-ID: <b7e2e9d1-5e3e-44b2-a4b7-327d334b776d@moroto.mountain>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>

On Sat, Jan 27, 2024 at 03:55:19PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 27 Jan 2024 15:43:42 +0100
> 
> The result from a call of the function “devm_kasprintf” was passed to
> a subsequent function call without checking for a null pointer before
> (according to a memory allocation failure).
> This issue was detected by using the Coccinelle software.
> 
> Thus return directly after a failed devm_kasprintf() call.
> 
> Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting support")

This basically doesn't affect runtime because perf_pmu_register() checks
for NULL so no need for a Fixes tag.

regards,
dan carpenter


