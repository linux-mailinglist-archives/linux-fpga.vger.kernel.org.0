Return-Path: <linux-fpga+bounces-561-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BDB913AAE
	for <lists+linux-fpga@lfdr.de>; Sun, 23 Jun 2024 14:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3571F21827
	for <lists+linux-fpga@lfdr.de>; Sun, 23 Jun 2024 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592B918130C;
	Sun, 23 Jun 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="h7CSl/lt"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305084D11;
	Sun, 23 Jun 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719147190; cv=none; b=O2oJtADA8eiD9YOF/B2Q69ZAzIs/vwpcjYf5u9eKFolFWSgYfc7DTjhHSIUpiMsAhWMDgug5cRvkyVB8BQNwPNQGjk8KmuXvOQW6Wqe39iz2eskDCNUuoHTfD3YWVuSXSFu0QxRUysGgDF8jdDYYRRhv2zb1FRZHsM9iKS86nRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719147190; c=relaxed/simple;
	bh=tg52MDDLlN/QzSd5br71obyGWmskQ0gXtkdQIAlXheE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=HV3uQgVOHjyaz6tQQr2U5F8FMdcGFpUIxGLPgeVBCu1gs1c+u/V9yT1QcypjpBMj6ahysdMBN8EbXmZxtcG0MYS7c6BY1uMiN2RCQH9hx/rntJRtvSpPWtW3RRxsT9vOTZfb3x1qIDruk8U3wZqu4AYGSJlWkjyJZbd9PYy5Erg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=h7CSl/lt; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719147167; x=1719751967; i=markus.elfring@web.de;
	bh=+e+KUzTHhhBB5U7l/lkuGhQUSnwTILvvurkTRpR4Wj4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h7CSl/lt4mctAPDSeosmwl6Skrsb3OvDu3TfM24qvEBcTk/9gzSt7/lh6xjoB0GH
	 cs10UCpedyc6ByYejHlCSO5SHr0VDdkJLKSfPB5PE2eSO81HbO/5+B4hZbQ+5t+rF
	 D1i6cIg0MzBWRS9EsEHbxEyKYfcY30ndW/1dxS1z6HBZaOSulun19mv1Iy6cOjVbJ
	 0DFuM3sOyjUKXD6ArJ3VJG8A98y8/Anl05vy1lA7DD3NnTdxkU3Xu5941ip5l9FU+
	 ZVKbosbDa4/f3FacHlcoWfBZPHnQvPxdqd3HuVe/uyH22O1KTgphIqtPWbjjgYCqn
	 AUtQ3dz6Dfttn9mbtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUXg-1svnvG3kOK-00mLLV; Sun, 23
 Jun 2024 14:52:46 +0200
Message-ID: <1bce6bf8-0010-4233-bbdd-4b33fde90c10@web.de>
Date: Sun, 23 Jun 2024 14:52:44 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, linux-fpga@vger.kernel.org,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240623074019.2083481-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] fpga: dfl: fix potential memory leak in
 vfio_intx_enable()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240623074019.2083481-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nJ9nL0iMXGQKoCo2kyKm2HzyM2UwCaAcKDxlRIYJNU1F4CEAKpY
 1XNrl02U76cGnvfRvsgICbKLoOhTAQsLFau2cSHOjPZWAxGBUiYvis7O9/vCB6G6motK2+S
 gsREbuy9QFaVRLtQ636icIzPLLyl9LDCFxIknzzSa1e/6bMaQ26J9YhTvceqdrbkDXwMlRv
 oM+2EwTzImsWDcRp835mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0FkaZsv/e3Y=;Csa9H2nAi380G/rRZAO4aYD7VvG
 XfUajr18iHQZZtgM7Gmh7NkpuIy1lCAhXBck48jEt/7k5E6kCcZLZ7JHenVSHBOWAwRKBlFow
 HPamh13rkikLuV2w0KdEytDxdXGH00vmr/xPmDgzsjoWvjQRZQQs8tqp9Dsmio8XSG5lNoL0r
 frMan746qHgY/h/vQ1UySCBukvaV4viFLadcZEod9tLBve33mwJ+m4xIu91z+jkJBIqjyueQJ
 v+E24ZEwIjE//nBldd5I7JUGmu+ACv1RUlqzdcyiTjs9qQfuSpFoGBuWIt6m0YUu8umyxkNtU
 YWXDa4QNAdDvVkCNG2Vlim89cTTcvV82GIE5hebzLp2o41rBNVfzGHT0ciPe7qSmRzUKZKxJT
 oO4nxEfDe4mOUjfLksSrA6bE5xKWshSUYIKSzD/Bs90V1/6Wr2ZNvT33Ro3BEPwCOrGMoQfYa
 a3qHe45vnWdDJaivlxs8DtGsOBurGxF9mtweSxa713Xu9UYaWmM3UX9It5848DBZaCK/fMjaB
 pPm9V+JfG5r8tJCoEOLphh1aKzZ7VM1MLKft966ZnxmOkJbHM49TXgGK4oPiepQwN6n5FU4MK
 nu1rcUhT4bI7HAlkxEA/+/3M8rctUUrvakaBQhjQILx9y/85jipZV3dVWjzj9Ywnl63Wc+b77
 IpCn7JSkJ3SP/OmTWvcq9cxWkIUKVZsCh3Xno2teZoZgI8s27cGMaoyf6HMBa6aeFCP4slpM3
 FlPBxETk6ayETrGLML06x3nBBX3nWvS0GzCkDNFQiskgcrUx45wIrTFxXkSFm6JGC1wBaPaev
 l04JkzNyNdgty8s5juXrXQrfkBm7v0W7G3oYMGjmtve50=

> We should free 'feature->irq_ctx[idx].name' to avoid 'name'
> memory leak when request_irq() failed.

1. Please choose an imperative wording for an improved change description.
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n94

2. Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?

3. How do you think about to use a summary phrase like =E2=80=9CAvoid memo=
ry leak
   in do_set_irq_trigger()=E2=80=9D?

4. Under which circumstances will development interests grow for increasin=
g
   the application of scope-based resource management?
   https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup=
.h#L8


Regards,
Markus

